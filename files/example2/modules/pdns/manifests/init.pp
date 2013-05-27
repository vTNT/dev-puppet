#
# pdns.pp - powerdns manage
#


class pdns {
	$dbserver="127.0.0.1"
	$dbname="pdns"
	$geozone="vmmatrix.com"
	package { 
		[ pdns,pdns-server,pdns-backend-geo,pdns-backend-mysql ]:
		ensure => installed,
	}
	
	config_file {
		"/etc/powerdns/pdns.d/pdns.local.gmysql":
		content => template("pdns/pdns.local.gmysql"),
		require => package["pdns-server"];
		"/etc/powerdns/pdns.d/pdns.local.geo":
		content => template("pdns/pdns.local.geo"),
		require => package["pdns-server"];
	}
		
	file {
		"/etc/powerdns/geo-maps":
		mode => 0755,
		require => package["pdns-server"],
		ensure => directory;
		"/etc/powerdns/pdns.conf":
		source => "puppet://$fileserver/pdns/pdns.conf",
		require => package["pdns-server"],
		
	}
	service {
		"pdns-recursor":
		ensure => stopped,
		pattern => "pdns_recursor";
	}
}
