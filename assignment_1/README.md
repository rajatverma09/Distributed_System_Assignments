COMMAND TO RUN:
cd dijkstra
mpic++ mpi_dijkstraVector.cpp -o mpi_dijkstraVector
mpirun --oversubscribe -np 4 mpi_dijkstraVector ./input_dijkstra2.txt ./output_dijkstra2.txt

cd quickSort
mpic++ mpi_qsortVector.cpp -o mpi_qsortVector
mpirun --oversubscribe -np 4 mpi_qsortVector ./input_qsort2.txt ./output_qsort2.txt
