set ns [new Simulator]
set nf [open PA1.nam w]
$ns namtrace-all $nf
set tf [open traceOutput1.tr w] 
$ns trace-all $tf

proc finish { } {     
    global ns nf tf
    $ns flush-trace     
    close $nf
    close $tf
    exec nam PA1.nam & 
    exit 0
}

set n0 [$ns node] 
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n2 200000b 10ms DropTail 
$ns duplex-link $n2 $n3 50000b 10ms DropTail

$ns queue-limit $n0 $n2 3
$ns queue-limit $n2 $n3 3

set udp0 [new Agent/UDP] 
$ns attach-agent $n0 $udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

set null0 [new Agent/Null] 
$ns attach-agent $n3 $null0
$ns connect $udp0 $null0

$ns at 0.1 "$cbr0 start"
$ns at 1.0 "finish"
$ns run

# grep command: grep -o 'needle' file | wc -l
