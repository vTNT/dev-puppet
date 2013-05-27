#
#


class lvs {
	package { 
		[ "keepalived","ipvsadm"]:
		ensure => installed;
	}
	
		
	file {
		"/etc/keepalived/keepalived.conf":
		source => "puppet://${fileserver}/lvs/${corp}.${idc}.keepalived.conf";
		"/usr/local/bin/keepalived.dns-pin":
		mode => 0755,
		source => "puppet://${fileserver}/lvs/keepalived.dns-pin";
		"/vmx-start.d/01ipvmset":
		mode => 0755,
		source => "puppet://${fileserver}/lvs/01ipvmset";
		
	}
}
