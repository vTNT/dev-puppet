#
# vmxcacti.pp manage cacti stuff
#


class vmxcacti{

	package { 
		[ vmx-cacti,php4-mysql,php4-cli,php4-gd,vmx-rrdtool,snmp ]:
		ensure => installed;
	}

	file {
		"/etc/cron.daily/cacti-backup-db":
		mode => 0755,
		source => "puppet://$fileserver/vmxcacti/cacti-backup-db",
		require => package ["vmx-cacti"];
		"/usr/local/bin/clean_squid_log.sh":
		mode => 0755,
		source => "puppet://$fileserver/vmxcacti/clean_squid_log.sh";
		"/etc/logrotate.d/vmxcacti":
		source => "puppet://$fileserver/cacti/cacti.logrotate";
	}
#	cron {
#		"clean_squid_log":
#		command => "/usr/local/bin/clean_squid_log.sh",
#		user => root,
#		environment => 'MAILTO=""',
#		hour => '*',
#		minute => '*';
#	}
}

class cactiforclient {
	$centercacti="10.0.8.106"
	$dbuser="root"
	# have some error "
	$dbpass="vmmatrix"
	include vmxcacti
	file {
		"/etc/cactiusers":
		source => "puppet://$fileserver/cdnusercacti/cactiusers";
		"/etc/disabledcactiusers":
		source => "puppet://$fileserver/cdnusercacti/disabledcactiusers";
		"/usr/local/bin/cacti_client_rt.sh":
		mode => 0755,
		content => template("vmxcacti/cacti_client_rt.erb");
		"/usr/local/bin/vmx-add-cacti-client.sh":
		mode => 0755,
		content => template("vmxcacti/vmx-add-cacti-client.erb");
		"/usr/local/bin/update-vmx-cacti-client.sh":
		mode => 0755,
		content => template("vmxcacti/update-vmx-cacti-client.erb");
		"/usr/local/bin/count_user_rt_and_push.sh":
		mode => 0755,
		content => template("vmxcacti/count_user_rt_and_push.erb");
		"/etc/cron.d/count_user_rt_and_push":
		source => "puppet://$fileserver/vmxcacti/count_user_rt_and_push.cron";
	}

#	exec {
#		"/usr/local/bin/update-vmx-cacti-client.sh":
#		timeout => 1700;
#	}
}

class centercacti{
	$dbuser="root"
	$dbpass="vmmatrix"
	include vmxcacti
	file {
		"/etc/cactiusers":
		source => "puppet://$fileserver/cdnusercacti/cactiusers";
		"/etc/disabledcactiusers":
		source => "puppet://$fileserver/cdnusercacti/disabledcactiusers";
		"/usr/local/bin/vmx-add-cacti-client.sh":
		mode => 0755,
		content => template("vmxcacti/vmx-add-centercacti-client.erb");
		"/usr/local/bin/update-vmx-centercacti-client.sh":
		mode => 0755,
		content => template("vmxcacti/update-vmx-cacti-client.erb");
		"/etc/apache2/conf.d/vmx-cacti-apache2.conf":
		source => "puppet://$fileserver/vmxcacti/vmx-cacti-apache2.conf";
	}

#	exec {
#		"update center cacti":
#		command => "/usr/local/bin/update-vmx-centercacti-client.sh",
#		timeout => 1700;
#	}
}

