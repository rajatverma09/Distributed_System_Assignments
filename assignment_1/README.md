**COMMAND TO RUN:**
<br/>
```
For Quick Sort:
cd quickSort
mpic++ mpi_qsortVector.cpp -o mpi_qsortVector
mpirun --oversubscribe -np 4 mpi_qsortVector ./input_qsort2.txt ./output_qsort2.txt
```
```
For Dijkstra:
cd dijkstra
mpic++ mpi_dijkstraVector.cpp -o mpi_dijkstraVector
mpirun --oversubscribe -np 4 mpi_dijkstraVector ./input_dijkstra2.txt ./output_dijkstra2.txt
```
<br/>
<br/>


**Parallel Quick Sort**<br/>
___Assumpsion:___: 
* For simplicity we use only closest 2^n process for this alogithm so that merging becomes simple. <br/>
* Number of process should be less than size of input array.

**ALGORITHM:**<br/>
1. Divide The given array into chunks and distribute to all the processes. Used MPI_Scatter for this purpose.
2. Apply quicksort to all the received chunks.
3. Now we have p(number of processes) chunks sorted locally but not globally. Apply tree based merging in parallel, this will merge the sorted chunks in O(log(p)).

**Parallel Dijkstra**<br/>
___Assumpsion:___:
* input array element should be less then INT_MAX


**ALGORITHM:**<br/>
1. Serialize the input adjancy matrix to linear vector.
2. Distribute nodes N amongst p process so every process gets N/p node responsiblity to calculate shortest distance from the source. Every process gets chunks to adjancy matrix in linear fastion. Used MPI_Scatter for this purpose.
3. call Dijkstra procedure that return local distance vector for each of there assigned nodes of graph.
4. Collect the local distance into global distance vector. Used MPI_Gatter for this purpose.

Dijkstra procedure:<br/>
1. Initialize source distance to 0 and all there distances to INF(INT_MAX).
2. Maintain two local vectors for every process as visited and local distance.
3. All the chunks will compute the local minimum from the serialized chunk it has.
4. These minimum distances are then sent to all and a global minimum distance and the node is computed by the gather function. This is the next nearest node.
5. After n steps, when all the nodes computed their global min distance, it's merged directly to give the output distance array.
