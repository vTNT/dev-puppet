#!/bin/sh
#If more than one IP or port Please '|' separated
ip="58.251.x.x|119.145.x.x"
port="80|443"
webconn=`netstat -nt |grep ESTABLISHED |awk '{print $4}'|awk '/('$ip'):('$port')/'| wc -l`
websyn=`netstat -nt |grep SYN_RECV |awk '{print $4}'|awk '/('$ip'):('$port')/'| wc -l`
weback=`netstat -nt |grep LAST_ACK |awk '{print $4}'|awk '/('$ip'):('$port')/'| wc -l`
webwait=`netstat -nt |grep TIME_WAI |awk '{print $4}'|awk '/('$ip'):('$port')/'| wc -l`
echo $webconn
echo $websyn
echo $weback
echo $webwait


