import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.Scanner;

public class Client {
   private Client() {
   }

   public static void main(String[] args) {
      String Server_ip = args[0];
      int Server_port = Integer.parseInt(args[1]);
      try {
         // Getting the registry
         Registry registry = LocateRegistry.getRegistry(Server_ip, Server_port);
         Scanner sc = new Scanner(System.in);
         // Looking up the registry for the remote object
         GraphInterface stub = (GraphInterface) registry.lookup("graph");
         while (sc.hasNextLine()){
            String command = sc.nextLine();
            String[] cmd = command.split(" ");
            if (cmd[0].equals("add_graph")) {
               String id = cmd[1];
               int n = Integer.parseInt(cmd[2]);
               stub.addGraph(id, n);
            } else if (cmd[0].equals("add_edge")) {
               String id = cmd[1];
               int u = Integer.parseInt(cmd[2]);
               int v = Integer.parseInt(cmd[3]);
               int w = Integer.parseInt(cmd[4]);
               stub.addEdge(id, u, v, w);
            } else if (cmd[0].equals("get_mst")) {
               String id = cmd[1];
               int mst = stub.getMST(id);
               System.out.println(mst);
            }
         }

      } catch (Exception e) {
         System.err.println("Client exception: " + e.toString());
         e.printStackTrace();
      }
   }
}