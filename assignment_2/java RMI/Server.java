import java.rmi.registry.Registry;
import java.rmi.registry.LocateRegistry;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class Server extends GraphImpl {
   public Server() {
   }

   public static void main(String args[]) {
      int Server_port = Integer.parseInt(args[0]);
      try {
         // Instantiating the implementation class
         GraphImpl obj = new GraphImpl();

         // Exporting the object of implementation class
         // (here we are exporting the remote object to the stub)
         GraphInterface stub = (GraphInterface) UnicastRemoteObject.exportObject(obj, 0);

         // Binding the remote object (stub) in the registry
         Registry registry = LocateRegistry.getRegistry(Server_port);

         registry.bind("graph", stub);
         System.err.println("Server ready");
      } catch (Exception e) {
         System.err.println("Server exception: " + e.toString());
         e.printStackTrace();
      }
   }
}