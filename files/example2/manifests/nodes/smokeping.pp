node 'smokeping1.waigao.vmmatrix.net' {
	file {
	"/opt/smokeping/etc/config": 
		source => "puppet:///local/$fqdn/config";
	"/opt/smokeping/etc/dns_targets": 
		source => "puppet:///local/$fqdn/dns_targets";
	"/opt/smokeping/etc/ping_targets": 
		source => "puppet:///local/$fqdn/ping_targets";
	"/opt/smokeping/etc/echoping_targets": 
		source => "puppet:///local/$fqdn/echoping_targets";
	}
	include dbp
	}

