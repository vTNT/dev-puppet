#
# debian.pp - debian base config 
# Copyrit (C) 2007 huangmingyou <huangmingyou@vmmatrix.com>
#



class dbp {

	# check os type
	
	case $operatingsystem {
		'Debian': { }
		default: { err("\$operatingsystem of ${fqdn} is not 'Debian' but '${operatingsystem}'.") }
	}

	
	# config apt
	
	config_file {
		"/etc/apt/sources.list":
			content => template("dbp/sources.list.erb");
		}
	
	# remove nouse packages
	package {
		[ nvi,lpr,ppp,pppconfig,pppoe,pppoeconf ]:
		ensure => present;
		[ rsync,ntpdate,curl,nload,tcpick,tcpdump,subversion,iproute,vim,lsb-release,rcconf,most ]:
		ensure => installed;
	}

	
	# file
	file {
		"/etc/localtime":
		mode => 0644,owner => root, group => root,
		source => "/usr/share/zoneinfo/Asia/Shanghai";
		"/etc/timezone":
		mode => 0644,owner => root, group => root,
		content => "Asia/Shanghai\n";
		"/root/.vimrc":
		mode => 0644,owner => root, group => root,
		source => "puppet://$fileserver/dbp/vimrc";
		"/root/.bashrc":
		mode => 0644,owner => root, group => root,
		source => "puppet://$fileserver/dbp/bashrc";
		"/vmx-backup":
		mode => 0755,owner => root, group => root,
		ensure => directory;
		"/root/.ssh/":
		mode => 0755,owner => root, group => root,
		ensure => directory;
		"/root/.ssh/authorized_keys2":
		source => "puppet://$fileserver/dbp/authorized_keys2";
		"/root/.ssh/authorized_keys":
		ensure => authorized_keys2;
		# add at 2008-01-07 for vmx-start ,Ticket #11 #
		"/etc/init.d/vmx-start":
		mode => 0755,owner => root, group => root,
		before => exec["install vmx-start"],
		source => "puppet://$fileserver/dbp/vmx-start";
		"/vmx-start.d":
		mode => 0755,owner => root, group => root,
		ensure => directory;
		"/vmx-start.d/00blockscheduler":
		mode => 0755,owner => root, group => root,
		source => "puppet://$fileserver/dbp/vmx-start.d/00blockscheduler";
		"/etc/sysctl.conf":
		source => "puppet://$fileserver/dbp/sysctl.conf";
		"/usr/local/bin/swapio":
		mode => 0755,
		source => "puppet://$fileserver/dbp/swapio";
		
	}	
	host { "sh-zj1.tele.trac.i.vmx.cn":
		ip => "10.0.7.2";
	}
	exec {
		"install vmx-start":
		command => "update-rc.d vmx-start defaults 99 0",
		creates => "/etc/rc2.d/S99vmx-start";
	}

}

