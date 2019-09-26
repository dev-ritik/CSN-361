#!/bin/bash
echo "Running $1.tcl"
echo ""
echo "    |Packet Drops --->"
echo "-------------------------------------------------------------"
xaxis=" Bandwidth in Mb ||v"
for (( i = 1; i < 20; i++ ))
do
	 unit="Mb"
	 ns "$1.tcl" 6 "$i$unit"
	 d="$(cat out.tr | grep -c d)"
	 bar=""
	 for (( j = 0; j < $d; j++ ))
	 do
	 	bar="#$bar"
	 done
	 if [[ i -lt 10 ]]; then
		 echo "${xaxis:$i:1}  $i|$bar($d)"
	 else
		 echo "${xaxis:$i:1} $i|$bar($d)"
	 fi
done

