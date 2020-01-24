/* MPI Program Template */

#include <iostream>
#include <vector>
#include <fstream>
#include <string>
#include "mpi.h"

#define ll long long int
#define ROOT 0
using namespace std;

int *findNonVisitedMinNode(vector<int> &local_dist, vector<bool> &visited)
{
    int rank;
    int local_N = local_dist.size();
    int *minDistU = new int[2];
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    minDistU[0] = INT_MAX;
    minDistU[1] = -1;
    for (int i = 0; i < local_N; i++)
    {
        if (!visited[i] && local_dist[i] < minDistU[0])
        {
            minDistU[0] = local_dist[i];
            minDistU[1] = rank * local_N + i;
        }
    }
    return minDistU;
}

vector<int> Dijkstra(vector<int> &local_mat, int local_N, int src, int N)
{
    int rank;
    vector<bool> visited(local_N, false);
    vector<int> local_dist(local_N, INT_MAX);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    if (rank * local_N + (src % local_N) == src)
        local_dist[src % local_N] = 0;
    int globalMinDistU[2];
    for (int i = 0; i < N; i++)
    {
        int *localMinDistU = findNonVisitedMinNode(local_dist, visited);
        MPI_Allreduce(localMinDistU, globalMinDistU, 1, MPI_2INT, MPI_MINLOC, MPI_COMM_WORLD);
        if (globalMinDistU[1] == -1)
            break;
        if ((globalMinDistU[1] / local_N) == rank)
            visited[globalMinDistU[1] % local_N] = true;
        for (int v = 0; v < local_N; v++)
        {
            if (!visited[v] && local_mat[globalMinDistU[1] + N * v] != INT_MAX)
            {
                int new_dist = globalMinDistU[0] + local_mat[globalMinDistU[1] + N * v];
                if (new_dist < local_dist[v])
                {
                    local_dist[v] = new_dist;
                }
            }
        }
    }
    return local_dist;
}

int main(int argc, char **argv)
{
    int rank, numprocs;

    /* start up MPI */
    MPI_Init(&argc, &argv);

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &numprocs);


/*------------------------------------------------------------------------*/
    vector<int> adj_mat, local_mat, global_dist, local_dist;
    int N, old_N, M, src;
    int x, y, w;
    int chunk_sz, local_N;
    if (rank == ROOT)
    {
        ifstream infile(argv[1]);
        infile >> old_N >> M;
        N = old_N;
        if (N % numprocs != 0)
            N = N + numprocs - (N % numprocs);
        adj_mat.resize(N * N, INT_MAX);
        global_dist.resize(N);
        for (int i = 0; i < N; i++)
            adj_mat[N * i + i] = 0;
        for (int i = 0; i < M; i++)
        {
            infile >> x >> y >> w;
            x--;
            y--;
            adj_mat[N * y + x] = w;
            adj_mat[N * x + y] = w;
        }
        infile >> src;
        src--;
    }
/*------------------------------------------------------------------------*/


    /*synchronize all processes*/
    MPI_Barrier(MPI_COMM_WORLD);
    double tbeg = MPI_Wtime();


/*------------------------------------------------------------------------*/
    /* write your code here */
    MPI_Bcast(&N, 1, MPI_INT, 0, MPI_COMM_WORLD);
    local_N = N / numprocs; /* we're assuming this divides evenly */
    local_mat.resize(local_N * N, INT_MAX);
    MPI_Scatter(static_cast<void *>(&adj_mat[0]), local_N * N, MPI_INT, static_cast<void *>(&local_mat[0]), local_N * N, MPI_INT, 0, MPI_COMM_WORLD);
    local_dist = Dijkstra(local_mat, local_N, src, N);
    global_dist.resize(N);
    MPI_Gather(static_cast<void *>(&local_dist[0]), local_N, MPI_INT, static_cast<void *>(&global_dist[0]), local_N, MPI_INT, 0, MPI_COMM_WORLD);
/*------------------------------------------------------------------------*/
  
  
    MPI_Barrier(MPI_COMM_WORLD);
    double elapsedTime = MPI_Wtime() - tbeg;
    double maxTime;
    MPI_Reduce(&elapsedTime, &maxTime, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);
    if (rank == 0)
    {
        printf("Total time (s): %f\n", maxTime);
    }


/*------------------------------------------------------------------------*/
    if (rank == ROOT)
    {
        ofstream outfile(argv[2]);
        for (int i = 0; i < old_N; i++)
        {
            if(global_dist[i] != INT_MAX)
                outfile << i + 1 << " " << global_dist[i] << endl;
            else
                outfile << i + 1 << " " << -1 << endl;
        }
    }
/*------------------------------------------------------------------------*/


    /* shut down MPI */
    MPI_Finalize();
    return 0;
}