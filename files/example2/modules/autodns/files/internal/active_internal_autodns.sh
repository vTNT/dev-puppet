#!/usr/bin/awk -f

####################################################
#       
# This file managed by puppet. don't edit by hand.
#       
####################################################


BEGIN{ RS="\}" }


$1 ~/service/ {
	for ( i=1 ; i<= NF ; i++) {
		if ( $i ~ "host_name=" ) split($i,hn,"=")
		if ( $i ~ "service_description=" ) split($i,sd,"=")
		if ( $i ~ "current_state=" ) split($i,cs,"=")
	}
	system ("/usr/local/bin/internal_autodns "sd[2]" "hn[2]" "cs[2]" HARD")
}
