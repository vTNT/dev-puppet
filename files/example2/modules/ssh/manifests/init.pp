#
# ssh/init.pp ssh config for debian (sarge & etch)
# Copyright (C) 2007 huangmingyou huangmingyou@vmmatrix.com
#

class ssh {
	package { 
		#
		# in etch, install openssh-server,will auto install the openssh-client;
		# in sarge, client and server command all in the ssh package.
		#
		"openssh-server":
		name => $lsbdistcodename ? {
			sarge => "ssh",
			etch  => "openssh-server",
		},
		ensure => installed;
	}
		 
	file {
		"/etc/ssh/sshd_config":
		mode => 0644, owner => root , group => root,
		source => $lsbdistcodename ?{
			sarge => "puppet://$fileserver/ssh/sshd_config.sarge",
			etch  => "puppet://$fileserver/ssh/sshd_config.etch",
			},
		require => package["openssh-server"],
	}

	service { ssh:
		ensure => running,
		pattern => "sshd",
		require => Package["openssh-server"],
		subscribe => File["/etc/ssh/sshd_config"],
	}
}
