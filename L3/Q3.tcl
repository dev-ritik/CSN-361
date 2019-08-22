## \file Q3.tcl
# File Tcl file for Star topography.
# Author Ritik

set ns [new Simulator]

$ns color 0 Red
$ns color 1 Blue
$ns color 2 Azure
$ns color 3 Coral
$ns color 4 Cyan

set f [open 3.nam w]
$ns namtrace-all $f

proc finish {} {
    global ns f
    $ns flush-trace
    close $f

    exec nam 3.nam &
    exit 0
}
puts "Enter no. of Nodes: "
gets stdin N
set n(0) [$ns node]
$ns at 0.0 "$n(0) label node0"

for {set i 1} {$i < $N} {incr i} {
    set n($i) [$ns node]
    $ns at 0.0 "$n($i) label node$i"
    $ns duplex-link $n($i) $n(0) 1Mb 10ms DropTail
}
puts "Enter k: "
gets stdin k
for {set i 0} {$i < $k} {incr i} {
    gets stdin i1
    gets stdin i2
    set tcp [new Agent/TCP]
    $tcp set class_ [expr $i%5]
    $ns attach-agent $n($i1) $tcp

    set sink [new Agent/TCPSink]
    $ns attach-agent $n($i2) $sink
    $ns connect $tcp $sink
    $tcp set fid_ $i

    set ftp($i) [new Application/FTP]
    $ftp($i) attach-agent $tcp
    $ftp($i) set type_ FTP
}
# $ns duplex-link $n0 $n1 1Mb 10ms DropTail

for {set i 0} {$i < $k} {incr i} {
    $ns at [expr ($i/5)] "$ftp($i) start"
    $ns at [expr ($i/5)+0.5] "$ftp($i) stop"
}
$ns at [expr ($k)+0.5] "finish"

$ns run