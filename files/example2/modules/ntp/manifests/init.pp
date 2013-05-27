#
# ntp.pp ntp-server config for debian (sarge & etch)
# Copyright (C) 2007 huangmingyou huangmingyou@vmmatrix.com
#

class ntp {
	package {
		"ntp-server":
		name => $lsbdistcodename ? {
			sarge => "ntp-server",
			etch => "ntp",
		},
		ensure => installed,
	}
	config_file {
		"/etc/ntp.conf":
		content => template("ntp/ntp.conf"),
		require => package["ntp-server"],
	}
	file {
		"/etc/cron.hourly/vmx-update-time":
		mode => 0755,
		content => template("ntp/vmx-update-time");
		
	}
	service { 
		"ntp":
		name => $lsbdistcodename ? {
			sarge => "ntp-server",
			etch => "ntp",
		},
		ensure => stopped,
		pattern => "ntpd";
#		require => package["ntp-server"],
#		subscribe => File["/etc/ntp.conf"],
	}
}
