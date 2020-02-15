**COMMANDS TO RUN:**
<br/>
```
javac -d classes/ *.java
cd classes
```
Run Server as:
```
java Server <server_port>
```
Run Client as:
```
java Client <server_ip> <server_port> < sample_input.txt
```
<br/>
<br/>

**ALGORITHM**<br>
*The algorithm used to implement the minimum spanning tree is Kruskal using disjoint set union*<br>
1. mst = 0;
2. number_of_edges = 0;
3. sort the edges according to increasing order of weights.
4. parent[] = makeset(n) ; n is number of nodes.
5. for each edge in sorted form
    * extract minimum weight edge from sorted edges connecting nodes u and v.
    * if(find(u) != find(v))
        * mst += weight_of_edge;
        * number_of_edges++;
        * union(u,v);
6. if(number of edges != n - 1)
        return -1;
4. return mst;

**Results**<br>
* Sample test cases are saved in classes dir as sample_input.txt and sample_output.txt
* Results can be verified from sample_output.txt
* sample test cases collected from: https://www.hackerrank.com/challenges/primsmstsub/submissions/code/142912454