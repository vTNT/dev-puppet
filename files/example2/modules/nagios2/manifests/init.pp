#
# nagios2
#


class nagios2 {
	include apache2
	$dirstruct = "/etc/nagios/target/{internet,vmx/{sh-wg,sh-zj,sh-nj,ln-sy},ido/sz-lg}"
	package {
		[ "vmx-nagios","vmx-nagios-plugins","vmx-nsca" ]:
		ensure => installed;
	}
	exec {
		"make directory":
		creates => "/etc/nagios/target/vmx",
		command => ": mkdir $dirstruct -p";
	}
	file { 
		"/var/log/nagios/rw":
		ensure => directory,mode => 0755,owner => nagios,group => nagios;
		"/etc/nagios/target":
		ensure => directory,mode => 0755;
		"/etc/nagios/target/internet":
		ensure => directory,mode => 0755;
		"/etc/nagios/target/${corp}":
		ensure => directory,mode => 0755;
		"/etc/nagios/target/${corp}/${idc}":
		ensure => directory,mode => 0755;
		"/etc/nagios/nagios.cfg":
		content => template ("nagios2/nagios.cfg.erb");
		"/etc/nagios/commands.cfg":
		source => "puppet://$fileserver/nagios2/commands.cfg";
		"/etc/nagios/localhost.cfg":
		source => "puppet://$fileserver/nagios2/localhost.cfg";
		#disable nscad"
		"/etc/init.d/nscad":
		mode => 0755,require => package["vmx-nsca"],
		content => "#!/bin/bash\nexit 0";
		"/usr/local/bin/submit_check_result":
                mode => 0755,
                content => template("nagios2/submit_check_result.erb");
		"/usr/local/bin/check_replication.pl":
		mode => 0755,
		source => "puppet://$fileserver/nagios2/check_replication.pl";

		"/usr/local/bin/check_vmxdnsdb.sh":
		mode => 0755,
		source => "puppet://$fileserver/nagios2/check_vmxdnsdb.sh";

		"/etc/cron.daily/rm_nagios_log_archive":
		mode => 0755,
		source => "puppet://$fileserver/nagios2/rm_nagios_log_archive";
	}

	define internet_service ( $ip = '',$check_command = '',$app='' ){
		file {
			"/etc/nagios/target/internet/${name}.cfg":
			ensure => present,
			mode => 0644,owner => root,group => root,
			content => template ( "nagios2/internet_service.erb");
		}
			
	}

	define internet_cache ( $ip = '' ) {
		nagios2::internet_service { 
			"$name":
			ip => $ip,
			app => "cache",
			check_command => "check_extsquid";
		}
	}
	
	define internet_dns ( $ip = '',$checkdomain='www.vmmatrix.com' ) {
		nagios2::internet_service { 
			"$name":
			ip => $ip,
			app => "dns",
			check_command => "check_dns!${checkdomain}";
		}
	}

		
	define host($squidtyp = '') {
		@@file {
			"/etc/nagios/target/${corp}/${idc}/${name}_host.cfg":
			ensure => present,
			tag => "${idc}",
			mode => 0644,owner => root,group => root,
			content => template ( "nagios2/host.erb");
		}
	}
        define service($check_command = '') {
                @@file {
                        "/etc/nagios/target/${corp}/${idc}/${name}_service.cfg":
                        ensure => present,
			tag => "${idc}",
                        mode => 0644,owner => root,group => root,
                        content => template ( "nagios2/service.erb");
                }
        }

			

	class squid {
		nagios2::host { $fqdn: }
		nagios2::service { "${fqdn}_cache": check_command => "check_extsquid"; }
	}
	class powerdns {
		nagios2::host { $fqdn: }
		nagios2::service { "${fqdn}_extpdns": check_command => "check_dns!www.vmmatrix.com"; }
	}

	class mysqlrep {
		nagios2::host { $fqdn: }
		nagios2::service { "${fqdn}_mysqlrep": check_command => "check_mysql_replication";}
		nagios2::service { "${fqdn}_vmxdnsdb": check_command => "check_vmxdnsdb";}
		
	}
	File <<| tag == "${idc}" |>>

}




class nagios2center {
	include apache2
	File <<| |>>
	$dirstruct = "/etc/nagios/target/{internet,vmx/{sh-zj,sh-nj,ln-sy},ido/sz-lg}"
	package {
		[ "vmx-nagios","vmx-nagios-plugins","vmx-nsca" ]:
		ensure => installed;
	}
	exec {
		"make directory":
		creates => "/etc/nagios/target/vmx",
		command => "mkdir $dirstruct -p";
	}
	file { 
		"/etc/nagios/nagios.cfg":
		content => template ("nagios2/center-nagios.cfg.erb");
		"/etc/nagios/center-commands.cfg":
		source => "puppet://$fileserver/nagios2/center-commands.cfg";
		"/etc/nagios/center-localhost.cfg":
		source => "puppet://$fileserver/nagios2/center-localhost.cfg";
		
		
		"/etc/nagios/nsca.cfg":
		require => package["vmx-nsca"],
		source => "puppet://$fileserver/nagios2/nsca.cfg";

		"/etc/cron.daily/rm_nagios_log_archive":
		mode => 0755,
		source => "puppet://$fileserver/nagios2/rm_nagios_log_archive";

	}

}
