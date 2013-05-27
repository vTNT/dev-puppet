#
# helixproxy manage
#


class behindhelixproxy{
	package { 
		"vmx-helixproxy":
		ensure => installed;
	}
	file {
		"/opt/helixproxy/rmproxy.cfg":
		require => package ["vmx-helixproxy"],
		source => "puppet://$fileserver/helixproxy/rmproxy.cfg";
	}
}


class fronthelixproxy inherits behindhelixproxy {
	package {
		[ "vmx-helixproxy-logsuite","mysql-client" ]:
		ensure => installed;
	
	}
}
