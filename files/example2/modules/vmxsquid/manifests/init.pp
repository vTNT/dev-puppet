#
# cache with carp
#
class basesquid {
		package { "snmpd": ensure => installed; }
		file {
		"/etc/snmp/snmpd.conf": 
		require => package["snmpd"],mode => 0600,
		source => "puppet://$fileserver/vmxsquid/snmpd.conf";
		}
	}

class frontsquid{
	package {
		"vmx-squid":
		ensure => installed;
		"vmx-squidlogsuite":
		ensure => latest;
	}
	file {
		"/etc/squid/special_query":
		require => package["vmx-squid"],
		source => "puppet://$fileserver/vmxsquid/special_query";
		"/etc/squid/conf.d/squid.conf":
		require => package["vmx-squid"],
		content => template ("vmxsquid/$corp.$idc.front.squid.conf.erb");
		"/etc/squid/vmx-squid.conf":
		require => package["vmx-squid"],
		source => "puppet://$fileserver/vmxsquid/$corp/$idc/vmx-squid.conf";
		"/usr/local/bin/rejectlvscheck.sh":
		mode => 0755,
		source => "puppet://$fileserver/vmxsquid/rejectlvscheck.sh";
		"/usr/local/bin/acceptlvscheck.sh":
		mode => 0755,
		source => "puppet://$fileserver/vmxsquid/acceptlvscheck.sh";
		"/etc/init.d/squid":
		require => package["vmx-squid"],
		mode => 0755,
		source => "puppet://$fileserver/vmxsquid/squid";
		#
		# squid soft dog
		#
		"/usr/local/bin/squid-softdog":
		mode => 0755,
		source => "puppet://$fileserver/vmxsquid/squid-softdog";
		"/etc/cron.d/squid-softdog":
		source => "puppet://$fileserver/vmxsquid/squid-softdog.cron";
		# 
		# puppetd crontab file
		#
		"/etc/cron.d/run-puppetd":
		ensure => absent ;
		#source => "puppet://$fileserver/vmxsquid/$corp/$idc/run-puppetd.cron";
		# update-squidbl.sh
		"/usr/local/bin/update-squidbl.sh":
		mode => 0755,
		source => "puppet://$fileserver/vmxsquid/${corp}/update-squidbl.sh";
		
		
	}


	# nagios check #
	$apptype="carpsquid"
	include nagios2::squid 
	include basesquid
	include	mailforward
}
class behindsquid{
	package {
		"vmx-squid":
		ensure => installed;
	}
	file {
		"/etc/squid/conf.d/squid.conf":
		content => template ("vmxsquid/behind.squid.conf.erb");
		#
		# squid soft dog
		#
		"/usr/local/bin/squid-softdog":
		mode => 0755,
		source => "puppet://$fileserver/vmxsquid/squid-softdog";
		"/etc/cron.d/squid-softdog":
		source => "puppet://$fileserver/vmxsquid/squid-softdog.cron";
		"/etc/cron.d/run-puppetd":
		ensure => absent ;
		#source => "puppet://$fileserver/vmxsquid/$corp/$idc/run-puppetd.cron";
	
		"/etc/squid/vmx-squid.conf":
		require => package["vmx-squid"],
		source => "puppet://$fileserver/vmxsquid/$corp/$idc/vmx-squid.conf";
		"/etc/cron.d/squid-push-mgr5min-cron":
		require => package["vmx-squid"],
		source => "puppet://$fileserver/vmxsquid/$corp/$idc/squid-push-mgr5min-cron";
		"/usr/bin/squid-push-mgr5min":
		require => package["vmx-squid"],
		mode => 0755,
		source => "puppet://$fileserver/vmxsquid/$corp/$idc/squid-push-mgr5min";

	}
	# nagios check #
	$apptype="cachesquid"
	include nagios2::squid
	include basesquid

}

class metasquid{
	$apptype="metasquid"
	include nagios2::squid 
	include basesquid
	package {
		["vmx-squid","vmx-squidlogsuite"]:
		ensure => installed;
	}
	file {
		"/etc/squid/conf.d/squid.conf":
		content => template ("vmxsquid/meta.squid.conf.erb");
		"/etc/squid/special_query":
		require => package["vmx-squid"],
		source => "puppet://$fileserver/vmxsquid/special_query";
		"/etc/squid/vmx-squid.conf":
		require => package["vmx-squid"],
		source => "puppet://$fileserver/vmxsquid/$corp/$idc/vmx-squid.conf";
		"/usr/local/bin/rejectlvscheck.sh":
		mode => 0755,
		source => "puppet://$fileserver/vmxsquid/rejectlvscheck.sh";
		"/usr/local/bin/acceptlvscheck.sh":
		mode => 0755,
		source => "puppet://$fileserver/vmxsquid/acceptlvscheck.sh.meta";
		"/etc/init.d/squid":
		require => package["vmx-squid"],
		mode => 0755,
		source => "puppet://$fileserver/vmxsquid/squid";
		#
		# squid soft dog
		#
		"/usr/local/bin/squid-softdog":
		mode => 0755,
		source => "puppet://$fileserver/vmxsquid/squid-softdog";
		"/etc/cron.d/squid-softdog":
		source => "puppet://$fileserver/vmxsquid/squid-softdog.cron";

		"/etc/cron.d/run-puppetd":
		ensure => absent ;
		#source => "puppet://$fileserver/vmxsquid/$corp/$idc/run-puppetd.cron";

	
	}
}
$apptype="dns"
