import java.rmi.Remote; 
import java.rmi.RemoteException;  

// Creating Remote interface for our application 
public interface GraphInterface extends Remote {  
   void addGraph(String id, int n) throws RemoteException;  
   void addEdge(String id, int u, int v, int w) throws RemoteException;  
   int getMST(String id) throws RemoteException;
} 