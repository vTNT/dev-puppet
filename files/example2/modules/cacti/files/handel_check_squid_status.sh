#!/bin/bash
#
# managed by puppet
#
cd /tmp/cacti
grep client_http.requests 10*|sed 's/:client_http.requests.*=/ /'|awk '{print $NF"\t"$1}'|sort -g
