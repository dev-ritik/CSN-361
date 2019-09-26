 set ns [new Simulator]

set namFile [open Q2.nam w]
$ns namtrace-all $namFile

set traceFile [open Q2.tr w]
$ns trace-all $traceFile

proc finish {}   {
    global ns traceFile namFile
    $ns flush-trace
    close $traceFile
    close $namFile

    exec nam Q2.nam &
    exec gawk -f Q2.awk Q2.tr &
    exit 0
}

 #Create the network
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

 #Creating Duplex-Link
$ns duplex-link $n0 $n2 .1Mb 10ms DropTail
$ns duplex-link $n2 $n1 .1Mb 10ms DropTail
$ns duplex-link $n2 $n3 .1Mb 10ms DropTail
$ns duplex-link $n3 $n4 .1Mb 10ms DropTail
$ns duplex-link $n3 $n5 .1Mb 10ms DropTail

set pingAgent0 [new Agent/Ping]
set pingAgent1 [new Agent/Ping]
set pingAgent2 [new Agent/Ping]
set pingAgent3 [new Agent/Ping]
set pingAgent4 [new Agent/Ping]
set pingAgent5 [new Agent/Ping]

$ns attach-agent $n0 $pingAgent0
$ns attach-agent $n1 $pingAgent1
$ns attach-agent $n2 $pingAgent2
$ns attach-agent $n3 $pingAgent3
$ns attach-agent $n4 $pingAgent4
$ns attach-agent $n5 $pingAgent5

$ns queue-limit $n0 $n2 2
$ns queue-limit $n2 $n1 2
$ns queue-limit $n2 $n3 1
$ns queue-limit $n3 $n4 2
$ns queue-limit $n3 $n5 2

$ns connect $pingAgent0 $pingAgent4
$ns connect $pingAgent5 $pingAgent1

$ns at 0.05 "$pingAgent0 send"
$ns at 0 "$pingAgent5 send"
$ns at 2.0 "finish"

$ns run