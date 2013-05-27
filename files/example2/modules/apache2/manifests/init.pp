#
# pdns.pp - powerdns manage
#


class apache2{
	package { 
		[ libapache2-mod-php4,php4,apache2 ]:
		ensure => installed;
	}
	
	host {
		"$fqdn":
		ip => $ipaddress;
	}		
	
	service {
		"apache2":
		ensure => running,
		pattern => "apache2",
	}
}
