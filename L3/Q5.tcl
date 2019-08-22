## \file Q5.tcl
# File Tcl file for Bus topography.
# Author Ritik

set ns [new Simulator]

$ns color 0 Red
$ns color 1 Blue
$ns color 2 Azure
$ns color 3 Coral
$ns color 4 Cyan

set f [open 5.nam w]
$ns namtrace-all $f

proc finish {} {
    global ns f
    $ns flush-trace
    close $f

    exec nam 5.nam &
    exit 0
}
puts "Enter no. of Nodes: "
gets stdin N
set n(0) [$ns node]
$ns at 0.0 "$n(0) label node0"
set y "$n(0)"
for {set i 1} {$i < $N} {incr i} {
    set n($i) [$ns node]
    $ns at 0.0 "$n($i) label node$i"
    # $ns duplex-link $n($i) $n(0) 1Mb 10ms DropTail
    append y " "
    append y "$n($i)"
    # $lan0 addNode "$n($i)" 1Mb 10ms
}
# set lan0 [$ns newLan $y 1Mb 10ms LL Queue/DropTail MAC/Csma/Cd Channel]

$ns make-lan $y 1Mb 10ms LL Queue/DropTail Mac/802_3
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
for {set i 0} {$i < $k} {incr i} {
    $ns at [expr ($i/3)+0.1] "$ftp($i) start"
    $ns at [expr ($i/3)+0.9] "$ftp($i) stop"
}
$ns at [expr ($k/10)+1.5] "finish"

$ns run
