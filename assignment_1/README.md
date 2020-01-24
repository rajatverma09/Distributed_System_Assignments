**COMMAND TO RUN:**
```
<br/>
cd dijkstra
<br/>
mpic++ mpi_dijkstraVector.cpp -o mpi_dijkstraVector
<br/>
mpirun --oversubscribe -np 4 mpi_dijkstraVector ./input_dijkstra2.txt ./output_dijkstra2.txt
```
<br/>
<br/>
```
cd quickSort
<br/>
mpic++ mpi_qsortVector.cpp -o mpi_qsortVector
<br/>
mpirun --oversubscribe -np 4 mpi_qsortVector ./input_qsort2.txt ./output_qsort2.txt
```
<br/>
