#!/bin/bash 
now=`/bin/date +%s`
ts=`echo $(($now-600))`
/usr/bin/mysql -u root squid_log -e "delete  from logs where time <${ts};"
