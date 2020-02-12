
// Implementing the remote interface 
import java.util.*;

public class GraphImpl implements GraphInterface {
   HashMap<String, Graph> Graph_map = new HashMap<String, Graph>(); 
   public String addGraph(String id, int n) 
   {
      Graph_map.put(id, new Graph(n));
      return "Graph with id " + id + " added";
   }

   public String addEdge(String id, int u, int v, int w)
   {
      Graph G = Graph_map.get(id);
      G.addEdge(u, v, w);
      return "Edge to Graph with id " + id + " added";
   }

   public int getMST(String id)
   {
      Graph G = Graph_map.get(id);
      return G.CalcMST();
   }
}