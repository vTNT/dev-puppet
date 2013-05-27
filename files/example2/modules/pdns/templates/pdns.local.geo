# geo Configuration
#
# See for more information /usr/share/doc/pdns-backend-geo/README
#
 geo-zone=<%= geozone %>
 geo-soa-values=ns1.vmmatrix.com,webmster@vmmatrix.com
 geo-ns-records=ns1.vmmatrix.com,ns3.vmmatrix.com
 geo-ip-map-zonefile=/etc/powerdns/zz.countries.nerd.dk.rbldnsd
 geo-maps=/etc/powerdns/geo-maps

# geo-ns-records=
 geo-ttl=300
 geo-ns-ttl=3600
# geo-ip-map-zonefile=
# geo-maps=

