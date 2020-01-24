/* MPI Program Template */

#include <fstream>
#include <vector>
#include <string>
#include <iostream>
#include <math.h>
#include <mpi.h>

#define ll long long int
#define ROOT 0
using namespace std;

void checkIsSorted(vector<ll> &chunk)
{
    for (ll i = 1; i < chunk.size(); i++)
        if (chunk[i] < chunk[i - 1])
        {
            cout << "NO" << endl;
            return;
        }
    cout << "YES" << endl;
    return;
}

ll partition(vector<ll> &arr, ll l, ll r)
{
    ll j = l;
    for (ll i = l; i < r; i++)
    {
        if (arr[i] <= arr[r])
        {
            swap(arr[i], arr[j]);
            j++;
        }
    }
    swap(arr[j], arr[r]);
    return j;
}

void quicksort(vector<ll> &arr, ll l, ll r)
{
    if (l >= r)
        return;
    ll p = partition(arr, l, r);
    quicksort(arr, l, p - 1);
    quicksort(arr, p + 1, r);
}

vector<ll> merge(vector<ll> &arr1, vector<ll> &arr2)
{
    ll i = 0, j = 0, k = 0;
    ll n1 = arr1.size(), n2 = arr2.size();
    vector<ll> result(n1 + n2);
    while (i < n1 && j < n2)
    {
        if (arr1[i] <= arr2[j])
            result[k++] = arr1[i++];
        else
            result[k++] = arr2[j++];
    }
    while (i < n1)
        result[k++] = arr1[i++];
    while (j < n2)
        result[k++] = arr2[j++];
    return result;
}

int main(int argc, char **argv)
{
    int rank, numprocs;

    /* start up MPI */
    MPI_Init(&argc, &argv);

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &numprocs);

/*---------------------------------------------------------*/
    ll n, chunk_sz, rec_sz, other_sz, step, p, i;
    vector<ll> Vdata, other, chunk;
    MPI_Status status;
    if (rank == ROOT)
    {
        ifstream infile(argv[1]);
        string line;
        while (std::getline(infile, line))
        {
            string tmp = "";
            Vdata.resize(0);
            line += ' ';
            for (ll i = 0; i < line.length(); i++)
            {
                if (line[i] == ' ')
                {
                    if (tmp.length() != 0)
                        Vdata.push_back(stoi(tmp));
                    tmp = "";
                }
                else
                {
                    tmp += line[i];
                }
            }
        }
        n = Vdata.size();
    }
/*---------------------------------------------------------*/

    /*synchronize all processes*/
    MPI_Barrier(MPI_COMM_WORLD);
    double tbeg = MPI_Wtime();

/*---------------------------------------------------------*/
    /* write your code here */
    MPI_Bcast(&n, 1, MPI_LONG_LONG_INT, 0, MPI_COMM_WORLD);
    p = pow(2, log2(numprocs));

    chunk_sz = (n % p == 0) ? n / p : n / p + 1;
    chunk.resize(chunk_sz);
    MPI_Scatter(static_cast<void *>(&Vdata[0]), chunk_sz, MPI_LONG_LONG_INT, static_cast<void *>(&chunk[0]), chunk_sz, MPI_LONG_LONG_INT, 0, MPI_COMM_WORLD);
    Vdata.clear();

    if (rank < p)
    {
        rec_sz = (n - chunk_sz * (rank + 1) > 0) ? chunk_sz : n - chunk_sz * rank;
        quicksort(chunk, 0, rec_sz - 1);
        for (step = 1; step < p; step = 2 * step)
        {
            if (rank % (2 * step) == 0)
            {
                if (rank + step < p)
                {
                    other_sz = (n - chunk_sz * (rank + 2 * step) > 0) ? chunk_sz * step : n - chunk_sz * (rank + step);
                    other.resize(other_sz);
                    MPI_Recv(static_cast<void *>(&other[0]), other_sz, MPI_LONG_LONG_INT, rank + step, 0, MPI_COMM_WORLD, &status);
                    chunk = merge(chunk, other);
                    rec_sz = rec_sz + other_sz;
                }
            }
            else
            {
                MPI_Send(static_cast<void *>(&chunk[0]), rec_sz, MPI_LONG_LONG_INT, rank - step, 0, MPI_COMM_WORLD);
                break;
            }
        }
    }
/*---------------------------------------------------------*/

    MPI_Barrier(MPI_COMM_WORLD);
    double elapsedTime = MPI_Wtime() - tbeg;
    double maxTime;
    MPI_Reduce(&elapsedTime, &maxTime, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);
    if (rank == 0)
    {
        printf("Total time (s): %f\n", maxTime);
    }

/*---------------------------------------------------------*/
    if (rank == ROOT)
    {
        ofstream outfile(argv[2]);
        for (i = 0; i < chunk.size(); i++)
        {
            outfile << chunk[i] << ' ';
        }
        // checkIsSorted(chunk);
    }
/*---------------------------------------------------------*/

    /* shut down MPI */
    MPI_Finalize();
    return 0;
}