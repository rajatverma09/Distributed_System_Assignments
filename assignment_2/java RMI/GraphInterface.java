import java.rmi.Remote; 
import java.rmi.RemoteException;  

// Creating Remote interface for our application 
public interface GraphInterface extends Remote {  
   String addGraph(String id, int n) throws RemoteException;  
   String addEdge(String id, int u, int v, int w) throws RemoteException;  
   int getMST(String id) throws RemoteException;
} 