#!/bin/bash


####################################################
# 
# This file managed by puppet. don't edit by hand.
# 
####################################################

PATH="/usr/bin:/bin:/usr/sbin:/sbin"
rcmd="pdnsd-ctl"
domain=${1#*_}
net=${1%_*}
ip=$2
state=$3
stype=$4

function addip () {
	domain=$1
	ip=$2
	net=$3
	# if now is in the backup state, add this ip direct.
	dig @127.0.0.1 $domain +short|grep  "${net}.${domain}"
	if [ $? -eq 0 ] ;then
		$rcmd add a $ip $domain
		exit 0
	fi
	# if not in the backup stae, add this ip and cached ip.	
	cacheip=$(dig @127.0.0.1 $domain +short|grep -i -v "[a-z]")
	r_cacheip=$(echo $cacheip|sed -e 's/ /,/g' -e "s/$/,$ip/")
	$rcmd add a $r_cacheip $domain
	}
function delip () {
	domain=$1
	ip=$2
	net=$3
	# if now in the backup state, exit direct.
	dig @127.0.0.1 $domain +short|grep  "${net}.${domain}"
	if [ $? -eq 0 ] ;then
		exit 0
	fi
	
	# if delete the last ip , then add the cname. into the backup state.
	cacheip=$(dig @127.0.0.1 $domain +short|grep -i -v "[a-z]"|grep -v "$ip")
	if [ "$cacheip" == "" ] ; then 
		$rcmd  add cname "$net.$domain" $domain
		$rcmd  empty-cache ${net}.${domain}
		exit 0
	fi

	# if this ip is not the last ip ,then delete this ip.
	r_cacheip=$(echo $cacheip|sed 's/ /,/g')
	$rcmd add a $r_cacheip $domain
}

case $state in 
	0|UP|OK) addip $domain $ip $net ;;
	2|DOWN|CRITICAL) delip $domain $ip $net ;;
	*) ;;
esac
