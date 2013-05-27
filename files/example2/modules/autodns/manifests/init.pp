#
# autodns
# Copyright (C) 2007,2008 huangmingyou huangmingyou@vmmatrix.com
#

class baseautodns {
	include apache2
	package { 
		["vmx-nagios","vmx-nsca","vmx-nagios-plugins"]:
		ensure => installed;
	}
	file {
		"/etc/cron.daily/rm_nagios_log_archive":
		mode => 0755,
		source => "puppet://$fileserver/nagios2/rm_nagios_log_archive";
		"/etc/cron.d/nagios-softdog":
		source => "puppet://$fileserver/autodns/nagios-softdog.cron";
		"/usr/local/bin/nagios-softdog":
		mode => 0755,
		source => "puppet://$fileserver/autodns/nagios-softdog";
	}
}

class externalautodns {
	include baseautodns
	file {
		"/var/log/nagios/rw":
		require => package["vmx-nagios"],
		mode => 0755,owner => nagios, group => nagios,
		ensure => directory;
		"/etc/nagios/iamlive.cfg":
		source => "puppet://$fileserver/autodns/external/iamlive.cfg.${nettype}";
		"/etc/nagios/node.list":
		before => exec["update external autodns domain list"],
		require => package["vmx-nagios"],
		source => "puppet://$fileserver/globalautodns/external.node.list";
		"/etc/nagios/domain.list":
		before => exec["update external autodns domain list"],
		require => package["vmx-nagios"],
		source => "puppet://$fileserver/globalautodns/external.domain.list";
		"/usr/local/bin/generate_external_domain.sh":
		before => exec["update external autodns domain list"],
		mode => 0755,
		content => template ("autodns/generate_external_domain.sh.erb");
		"/usr/local/bin/generate_external_domain.libs":
		before => exec["update external autodns domain list"],
		source => "puppet://$fileserver/autodns/external/generate_external_domain.libs";
		"/etc/nagios/nagios.cfg":
		content => template ("autodns/external.nagios.cfg.erb");
		"/etc/nagios/commands.cfg":
		source => "puppet://$fileserver/autodns/external/commands.cfg";
		"/etc/nagios/templates.cfg":
		source => "puppet://$fileserver/autodns/external/templates.cfg";

		
		# nsca conf
		"/etc/nagios/nsca.cfg":
		require => package["vmx-nsca"],
		source => "puppet://$fileserver/autodns/external/nsca.cfg";

		# shell script
		"/usr/local/bin/active_auto_dns":
		mode=>0755,
		source => "puppet://$fileserver/autodns/external/active_auto_dns";

		"/usr/local/bin/auto_dns":
		mode=>0755,
		source => "puppet://$fileserver/autodns/external/auto_dns";

		"/usr/local/bin/no_nsca_report":
		mode => 0755,
		source => "puppet://$fileserver/autodns/external/no_nsca_report";

		"/etc/cron.d/auto_dns":
		source => "puppet://$fileserver/autodns/external/auto_dns.cron";
		"/usr/local/bin/start_stop_bind":
		mode => 0755,
		source => "puppet://$fileserver/autodns/external/start_stop_bind";

		"/etc/cron.d/start_stop_bind":
		source => "puppet://$fileserver/autodns/external/start_stop_bind.cron";

		"/usr/local/bin/submit_check_result":
		mode => 0755,
		content => template ("autodns/submit_check_result");


	}
	exec {
		"update external autodns domain list":
		timeout => "10",
		command => "/usr/local/bin/generate_external_domain.sh";
	}
}

class internalautodns {
	include baseautodns
	package { 
		"vmx-pdnsd": ensure => installed;
		"pdnsd": ensure => absent; 
	}
	file {
		# for vmx-pdnsd #

		"/etc/pdnsd.conf":
		require => package["vmx-pdnsd"],
		source => "puppet://$fileserver/autodns/internal/pdnsd.conf.${corp}";
		"/usr/local/bin/check_dns":
		mode => 0755,
		source => "puppet://$fileserver/proxydns/check_dns";
	
		# for vmx-nagios #
		"/etc/nagios/nagios.cfg":
		content => template ("autodns/nagios.cfg.erb");
		"/etc/nagios/commands.cfg":
		source => "puppet://$fileserver/autodns/internal/commands.cfg";
		"/etc/nagios/templates.cfg":
		source => "puppet://$fileserver/autodns/internal/templates.cfg";
		"/usr/local/bin/internal_autodns":
		mode => 0755,
		source => "puppet://$fileserver/autodns/internal/internal_autodns.sh";
		"/usr/local/bin/active_internal_autodns":
		mode => 0755,
		source => "puppet://$fileserver/autodns/internal/active_internal_autodns.sh";
		"/etc/cron.d/active_internal_autodns":
		source => "puppet://$fileserver/autodns/internal/active_internal_autodns.cron";
		"/usr/local/bin/generate_domain.sh":
		require => package["vmx-nagios"],mode => 0755,
		source => "puppet://$fileserver/autodns/internal/generate_domain.sh";
		"/etc/nagios/domain.list":
		require => package["vmx-nagios"],
		before => exec["update internal autodns domain list"],
		source => "puppet://$fileserver/globalautodns/domain.list.internal";
		# soft dog
		"/usr/local/bin/vmx-pdnsd-softdog":
		mode => 0755,
		source => "puppet://$fileserver/autodns/internal/vmx-pdnsd-softdog";
		"/etc/cron.d/vmx-pdnsd-softdog":
		source => "puppet://$fileserver/autodns/internal/vmx-pdnsd-softdog.cron";
		"/etc/cron.d/pdnsd-softdog-cron":
		ensure => absent;
	}	
	exec {
		"update internal autodns domain list":
		timeout => "10",
		command => "/usr/local/bin/generate_domain.sh";
	}

}

