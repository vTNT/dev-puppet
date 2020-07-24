#!/usr/bin/env python
#
# this script returns the server-id of the current main
# cluster name must be in /etc/db.cluster, set by puppet
# and $cluster-main should be an up-to-date CNAME to
# the main.
#

from socket import gethostbyname
maindom = '.pmtpa.wmnet'

f = open('/etc/db.cluster', 'r')
c = f.readline()
mip = gethostbyname(c.split()[0] + '-main' + maindom)
octets = mip.split('.')
print octets[0] + octets[2] + octets[3]
