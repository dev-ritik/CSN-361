#!/bin/bash
echo "Running $1.tcl"
echo ""
echo "    |Packet Drops --->"
echo "-------------------------------------------------------------"
xaxis="Queue length |||v   "
for (( i = 0; i < 20; i++ )); do
	 ns "$1.tcl" $i 1Mb
	 d="$(cat out.tr | grep -c d)"
	 bar=""
	 for (( j = 0; j < $d; j++ )); do
	 	bar="#$bar"
	 done
	 if [[ i -lt 10 ]]; then
		 echo "${xaxis:$i:1}  $i|$bar($d)"
	 else
		 echo "${xaxis:$i:1} $i|$bar($d)"
	 fi
done
