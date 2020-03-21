**COMMANDS TO RUN:**
<br/>
```
For Problem-1:
erlc 2018201040_1.erl
erl -noshell -s 2018201040_1 main <input_file> <output_file> -s init stop
```
```
For Problem-2:
erlc 2018201040_2.erl
erl -noshell -s 2018201040_2 main <input_file> <output_file> -s init stop
```
<br/>
<br/>

**Problem-1**<br/>
___Assumpsion:___: 
* Solution is tested for only upto 10 processes, extremes may depend on computer's performance.
* To avoid deadlock reference number is used so that token is received to only the correct recipient.<br>

**ALGORITHM**<br>
1. main process spawns N processes and each wait for the token.
2. Starting with main process as process 0, having the token sends it to spawned process 1\.
3. This process sends it to next process and contiues till N - 1.
4. Last process sends the token back to main process.

**Problem-2**<br/>
___Assumpsion:___: 
* Number of processes spawned are equal to number of cores in the CPU, in my case it is 8.
* To avoid message delivery to incorrect process reference number and parent process id is used.<br>

**ALGORITHM**<br>
1. Parallel mergesort takes a list of integers.
2. Divide the list into 2 halves.
3. Spawn 2 child processes and pass the 2 halves to both, do this recursively until list size is not 1 or number of process to be spawned less than 2.
4. If number of processes to be spawned become less than 2 do sequential 2-way merge sort on the current outstanding list.
5. On return from recursive call receive the result from left and right child process.
6. merge the received list and return to its parent.

