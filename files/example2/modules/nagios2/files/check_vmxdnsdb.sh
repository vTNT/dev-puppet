#!/bin/bash
#set -x
help () {
	cat <<EOF
useage: $0 [options]
-u username
-p password
-m master host
-s slave host
EOF
exit 0
}



[ $# -ne 8 ]&&help
while getopts "u:p:m:s:" opt;do
	case $opt in 
	u)user=$OPTARG;;
	p)pass=$OPTARG;;
	s)slave=$OPTARG;;
	m)master=$OPTARG;;
	*);;
	esac
done

a=$(mysql -B -u $user -p$pass -h $master -e "select count(*) from pdns.records;"|grep -v count)
b=$(mysql -B -u $user -p$pass -h $slave -e "select count(*) from pdns.records;"|grep -v count)
a1=${a:-1}
b1=${b:-2}
[ $a1 -ne $b1 ]&&exit 2
c=$(mysql -B -u $user -p$pass -h $master -e "select count(*) from pdns_loc.records;"|grep -v count)
d=$(mysql -B -u $user -p$pass -h $slave -e "select count(*) from pdns_loc.records;"|grep -v count)
c1=${c:-1}
d1=${d:-2}
[ $c1 -ne $d1 ]&&exit 2
exit 0
