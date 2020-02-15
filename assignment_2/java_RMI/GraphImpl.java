
// Implementing the remote interface 
import java.util.*;

public class GraphImpl implements GraphInterface {
   HashMap<String, Graph> Graph_map = new HashMap<String, Graph>(); 
   public void addGraph(String id, int n) 
   {
      Graph_map.put(id, new Graph(n));
   }

   public void addEdge(String id, int u, int v, int w)
   {
      Graph G = Graph_map.get(id);
      u--;
      v--;
      G.addEdge(u, v, w);
   }

   public int getMST(String id)
   {
      Graph G = Graph_map.get(id);
      return G.CalcMST();
   }
}