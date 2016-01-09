Copy Makefile, gen.c & proj3.sh into the directory.
	
To run the example code type : 
    ./proj3.sh 4 4 12 0
The format being ./proj3.sh k p b g. Where:
=> k is the number of values a vector can hold, 
=> p is the level of parallelism, (p==1||p==k)
=> b is the size of each value
=> g is the the levels of pipelining in each mac module. g is either 0 or 1

The script file does the following commands:

"make"
=>builds the c file

"./gen $k $p $b $g"
=> compiles the gen.c
=> runs the gen.c with given variables

"vlib work"
=> creates the work library for simulation

"vlog p_vyas_mvm_tb_"$k"_"$p"_"$b"_"$g".sv"
=> compiles testbench of corresponding .sv file

" vsim tbench -c -do "run -all" "
=> simulates the test bench.

"diff -w expectedOutput_"$k"_"$p"_"$b"_"$g" outValues_"$k"_"$p"_"$b"_"$g" ""
=> finds the difference between inputs and the test bench.


If the user enters any illegal set of inputs, an error message will be displayed on the terminal
conveying what the legal sets of inputs should be.


