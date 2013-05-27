#
# cacti
#
class basecacti {
	#include mysql-server-41
	package {
		[ "squidclient","snmp","vmx-rrdtool","vmx-cacti","php4-mysql"]:
		ensure => installed;
	}
	host {
		"carpsquid":
		alias => ["cachesquid","metasquid"],
		ip => "127.0.0.5";
	}
	file {
		"/var/www/vmx-cacti/cmd-php-non-unique-hosts.patch":
		require => package["vmx-cacti"],
		source => "puppet://$fileserver/cacti/cmd-php-non-unique-hosts.patch";
		"/var/www/vmx-cacti/graph-issue-wrra-specs.patch":
		require => package["vmx-cacti"],
		source => "puppet://$fileserver/cacti/graph-issue-wrra-specs.patch";
		"/etc/cron.daily/cacti-backup-db":
		mode => 0756,
		source => "puppet://$fileserver/cacti/cacti-backup-db";
		"/usr/local/bin/cacti":
		ensure => directory,mode => 0755;
		"/etc/logrotate.d/vmxcacti":
		source => "puppet://$fileserver/cacti/cacti.logrotate";
		
	}

	exec {
		"make cacti 0.8.7a patch":
		command => "cd /var/www/vmx-cacti/;/usr/bin/patch -p1 -N < graph-issue-wrra-specs.patch;/usr/bin/patch -p1 -N < cmd-php-non-unique-hosts.patch;touch patch.stamp",
		timeout => 10,
		creates => "/var/www/vmx-cacti/patch.stamp";
		"create cacti database":
		command => "mysql -e 'create database cacti'",
		creates => "/var/lib/mysql/cacti";
		
	}
	
}

class cacti{
	include basecacti
	file {
		"/usr/local/bin/cacti-discovery-squid":
		mode => 0755,
		content => template("cacti/cacti-discovery-squid.erb");
		"/usr/local/bin/cacti/get_2value_from_mgr5min":
		mode => 0755,
		source => "puppet://$fileserver/cacti/get_2value_from_mgr5min";
		"/usr/local/bin/cacti/get_swapio":
		mode => 0755,
		source => "puppet://$fileserver/cacti/get_swapio";
		"/usr/local/bin/cacti-update-host":
		mode => 0755,
		content => template("cacti/cacti-update-host.erb");
		"/etc/cron.d/cacti-discovery":
		content => "MAILTO=''\n2,7,12,17,22,27,32,37,42,47,52,57 * * * * root /usr/local/bin/cacti-discovery-squid\n";
		"/usr/local/src/vmx_cacti_template_v1.sql":
		source => "puppet://$fileserver/cacti/vmx_cacti_template_v1.sql";
		"/usr/local/bin/sum_all_mgr5min":
		mode => 0755,
		source => "puppet://$fileserver/cacti/sum_all_mgr5min";
		"/usr/local/bin/handel_check_squid_status.sh":
		mode => 0755,
		source => "puppet://$fileserver/cacti/handel_check_squid_status.sh";
		"/usr/local/bin/rsync_squidlog_2center.sh":
		mode => 0755,
		content => template("cacti/rsync_squidlog_2center.erb");
		"/usr/local/bin/pull_and_put_log.sh":
		mode => 0755,
		content => template("cacti/pull_and_put_log.erb");
		"/usr/local/bin/sum_all_mgr5min_noupdate":
		mode => 0755,
		source => "puppet://$fileserver/cacti/sum_all_mgr5min_noupdate";
		"/etc/cron.d/pull_and_put_log":
		content => "MAILTO=''\n* * * * * root /usr/local/bin/pull_and_put_log.sh\n";

	}

}

class cacticenter {
	include basecacti
	file {
		"/usr/local/bin/cacti/get_2value_from_allsquidmgr5min":
		mode => 0755,
		source => "puppet://$fileserver/cacti/get_2value_from_allsquidmgr5min";
		"/usr/local/bin/cacti/sum_all_squidmgr5min":
		mode => 0755,
		source => "puppet://$fileserver/cacti/sum_all_squidmgr5min";
		"/etc/cron.d/sum_allsquid_mgr5min":
		content => "MAILTO=''\n* * * * * root /usr/local/bin/cacti/sum_all_squidmgr5min\n";
		"/etc/rsyncd.conf":
		source => "puppet://$fileserver/cacti/rsyncd.conf";
		"/opt/squidlog":
		owner => nobody,group => nogroup,
		ensure => directory;
	}
}
