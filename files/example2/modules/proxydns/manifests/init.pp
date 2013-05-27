#
# pdns.pp - powerdns manage
#


class proxydns {
	package { 
		[ pdnsd ]:
		ensure => installed;
	}
	
		
	file {
		"/etc/pdnsd.conf":
		source => "puppet://$fileserver/proxydns/pdnsd.conf.$proxydnstype",
		require => package["pdnsd"];
		"/usr/local/bin/check_dns":
		mode => 0755,
		source => "puppet://$fileserver/proxydns/check_dns";
		
	}
	
	
}
