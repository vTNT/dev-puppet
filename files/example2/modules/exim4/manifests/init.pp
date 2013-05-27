#
# exim4.pp exim4 config
#


class mailforward {
		
	package {
		[ exim4,exim4-base,exim4-config,exim4-daemon-heavy ]:
		ensure => installed;
		}


	file {
		"/var/log/exim4":
		ensure => directory,mode => 2750,owner =>Debian-exim,group => adm;
		"/etc/mailname":
		source => "/etc/hostname";
		"/etc/exim4/exim4.conf":
		source => "puppet://$fileserver/exim4/exim4.conf";
		}
}
