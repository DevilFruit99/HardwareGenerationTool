make
k=$1
p=$2
b=$3
g=$4

./gen $k $p $b $g
vlib work
vlog p_vyas_mvm_tb_"$k"_"$p"_"$b"_"$g".sv
vsim tbench -c -do "run -all"
diff -w expectedOutput_"$k"_"$p"_"$b"_"$g" outValues_"$k"_"$p"_"$b"_"$g" #-w to ignore whitespaces
echo
echo

if test "$k" -lt 1 || test "$p" -lt 1 || test "$b" -lt 1 || test "$g" -gt 1 || test "$g" -lt 0 || test "$p" -gt 1 -a "$p" -lt "$k" || test "$p" -gt "$k"
then
    echo "invalid entry." 
	echo
 echo "k p b should be a positive nonzero integer"
 echo
	
	echo "g can have two cases 0 or 1"
	echo
	
	echo "p can have two cases 1 or k"
	echo
	
else

echo
echo "refData_"$k"_"$p"_"$b"_"$g" => this file contains randomly generated inputs."
echo
echo "expectedOutput_"$k"_"$p"_"$b"_"$g" => this file contains the output that is expected from the hardware."
echo
echo "outValues_"$k"_"$p"_"$b"_"$g" => this file contains the output of our hardware."
fi
echo