
import java.util.*;

public class Graph {
    class Edge {
        int source;
        int destination;
        int weight;

        public Edge(int source, int destination, int weight) {
            this.source = source;
            this.destination = destination;
            this.weight = weight;
        }
    }

    class weightComp implements Comparator<Edge> {

        @Override
        public int compare(Edge e1, Edge e2) {
            if (e1.weight >= e2.weight) {
                return 1;
            } else {
                return -1;
            }
        }
    }

    int N;
    LinkedList<Edge> edges = new LinkedList<>();
    int[] parent;

    private int find(int u) {
        if (u != parent[u])
            return parent[u] = find(parent[u]);
        return parent[u];
    }

    private void union(int u, int v) {
        int x = find(u);
        int y = find(v);
        if (x < y)  
            parent[y] = x;
        else
            parent[x] = y;
    }

    Graph(int N) {
        this.N = N;
        parent = new int[this.N];
    }

    public void addEdge(int u, int v, int w) {
        Edge edge = new Edge(u, v, w);
        edges.add(edge);
        // try{
        // Thread.sleep(60000);
        // }
        // catch(InterruptedException e)
        // {
        //     System.out.println(e);
        // }
    }

    public int CalcMST() {
        int mst = 0, mst_edges = 0;
        LinkedList<Edge> new_edges = new LinkedList<Edge>(edges);
        Collections.sort(new_edges, new weightComp());

        for (int i = 0; i < N; i++)
            parent[i] = i;

        while (!new_edges.isEmpty()) {
            Edge edge = new_edges.remove();
            int u = find(edge.source);
            int v = find(edge.destination);
            if (u != v) {
                union(u, v);
                mst_edges++;
                mst += edge.weight;
            }
        }
        if(mst_edges == N - 1)
            return mst;
        return -1;
    }
}
