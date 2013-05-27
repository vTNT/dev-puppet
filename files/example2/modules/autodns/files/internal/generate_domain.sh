#!/bin/bash 

#
# don't edit by hand.
#


PATH="/usr/bin:/bin:/usr/sbin:/sbin"
mkdir /etc/nagios/autodns/{tele,cnc,cm,edu,all} -p
find /etc/nagios/autodns |xargs /bin/rm  2>/dev/null

grep -v -e '#' -e '^$' /etc/nagios/domain.list |mawk '$0 !~ /#/ {
	print  "define host {\n\tuse\t\tlinux-server\n\thost_name\t"$1"\n\talias\t\t"$3"_"$2"\n\taddress\t\t"$1"\n}\ndefine service {\n\tservice_description\t"$3"_"$2"\n\tuse\t\t\tlocal-service\n\thost_name\t\t"$1"\n\tcheck_command\t\t"$4"\n}" > "/etc/nagios/autodns/"$3"/"$1".cfg"}' 
