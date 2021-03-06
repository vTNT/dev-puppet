# backups (amanda)
#


class backup::server {


	package { [ "amanda-common", "amanda-server" ]:
		ensure => latest;
	}

	file {
		"/var/backups/.ssh/authorized_keys":
			owner	=>	backup,
			group	=>	backup,
			mode	=>	0600,
			source 	=>	"puppet:///private/backup/ssh-keys/authorized_keys_server";

		"/var/backups/.ssh/amanda_restore":
			owner	=>	backup,
			group	=>	backup,
			mode	=>	0600,
			source 	=>	"puppet:///private/backup/ssh-keys/amanda_restore";
		"/etc/amanda/create_vtapes.sh":
			owner	=>	root,
			group	=>	root,
			mode	=>	0700, 
			source	=>	"puppet:///files/backup/create_vtape.sh";
	}
	File <<| tag == "backup_host" |>>
	
	#service {
	#	xinetd:
	#		ensure	=>	stopped;
	#}


	cron {
		amanda_daily:
		command =>	"/usr/sbin/amdump Wikimedia-Daily",
		require =>	Package["amanda-server"],
		user	=>	backup,
		hour	=>	2,
		minute	=>	0;

		amanda_weekly:
		command	=>	"/usr/sbin/amdump Wikimedia-Weekly",
		require =>	Package["amanda-server"],
		user	=>	backup,
		hour	=>	6,
		minute	=>	0,
		weekday	=>	Sunday;

		amanda_monthly:
		command	=>	"/usr/sbin/amdump Wikimedia-Monthly",
		require =>	Package["amanda-server"],
		user	=>	backup,
		hour	=>	12,
		minute	=>	0,
		monthday =>	1;
	}
	
	include backup::server::daily
	include backup::server::weekly
	include backup::server::monthly			

}

class backup::server::daily {
	$mailto_account = "ops@wikimedia.org"
	$cycle_type = "Wikimedia-Daily"
        $vtapes_location = "/data/amanda/Wikimedia-Daily"
	$conf_location	= "/etc/amanda/Wikimedia-Daily"
        $tape_length = "200 gbytes"
        $tape_num = 6
	$dumpcycle = "6 days"
	$runspercycle = 1
	$tapecycle = "6 tapes"
	$incr_type = "incronly"
	$backup_priority = "high"
	$compress_type = "client fast"

	file {
		"$conf_location":
			owner	=>	root,
			group	=>	root,
			mode	=>	0777,
			purge	=>	false,
			require =>	Package["amanda-server"],
			ensure	=>	directory;
		"$conf_location/amanda.conf":
			owner	=>	root,
			group	=>	root,
			mode	=>	0644,
			require =>	File["$conf_location"],
			content	=>	template("backups/amanda-server.conf.erb");
		"$conf_location/logs":
			owner	=>	backup,
			group	=>	backup,
			mode	=>	0755,
			purge	=>	false,
			require =>	File["$conf_location"],
			ensure	=>	directory;
		"$conf_location/index":
			owner	=>	backup,
			group	=>	backup,
			mode	=>	0755,
			purge	=>	false,
			require =>	File["$conf_location"],
			ensure	=>	directory;
		"$conf_location/curinfo":
			owner	=>	backup,
			group	=>	backup,
			mode	=>	0755,
			purge	=>	false,
			require =>	File["$conf_location"],
			ensure	=>	directory;
		"$conf_location/tapelist":
			owner	=>	backup,
			group	=>	backup,
			require =>	File["$conf_location"],
			mode 	=>	0644;
		"$conf_location/disklist":
			owner	=>	root,
			group	=>	root,
			mode	=>	0644,
			require =>	File["$conf_location"],
			source	=>	"puppet:///files/backup/disklist-daily";	
	}

	exec {
		create_daily_vtapes:
			command	=>	"/etc/amanda/create_vtapes.sh $cycle_type $tape_num $vtapes_location",
			require	=>	[ File["/etc/amanda/create_vtapes.sh"], File["$conf_location"] ],
			user	=>	root;
	}

}

class backup::server::weekly {
	$mailto_account = "ops@wikimedia.org"
	$cycle_type = "Wikimedia-Weekly"
        $vtapes_location = "/data/amanda/Wikimedia-Weekly"
	$conf_location = "/etc/amanda/Wikimedia-Weekly"
        $tape_length = "200 gbytes"
        $tape_num = 4
	$dumpcycle = "4 weeks"
	$runspercycle = 1
	$tapecycle = "4 tapes"
	$incr_type = "standard"
	$backup_priority = "medium"
	$compress_type = "client fast"

	file {
		"$conf_location":
			owner	=>	root,
			group	=>	root,
			mode	=>	0777,
			purge	=>	false,
			require =>	Package["amanda-server"],
			ensure	=>	directory;
		"$conf_location/amanda.conf":
			owner	=>	root,
			group	=>	root,
			mode	=>	0644,
			content	=>	template("backups/amanda-server.conf.erb"),
			require =>	File["$conf_location"];
		"$conf_location/logs":
			owner	=>	backup,
			group	=>	backup,
			mode	=>	0755,
			purge	=>	false,
			ensure	=>	directory,
			require =>	File["$conf_location"];
		"$conf_location/index":
			owner	=>	backup,
			group	=>	backup,
			mode	=>	0755,
			purge	=>	false,
			ensure	=>	directory,
			require	=>	File["$conf_location"];
		"$conf_location/curinfo":
			owner	=>	backup,
			group	=>	backup,
			mode	=>	0755,
			purge	=>	false,
			ensure	=>	directory,
			require	=>	File["$conf_location"];
		"$conf_location/tapelist":
			owner	=>	backup,
			group	=>	backup,
			mode	=>	0644,
			require =>	File["$conf_location"];
		"$conf_location/disklist":
			owner	=>	root,
			group	=>	root,
			mode	=>	0644,
			source	=>	"puppet:///files/backup/disklist-weekly",
			require =>	File["$conf_location"];
	}

	exec {
		create_weekly_vtapes:
			command	=>	"/etc/amanda/create_vtapes.sh $cycle_type $tape_num $vtapes_location",
			require	=>	[ File["/etc/amanda/create_vtapes.sh"], File["$conf_location"] ],
			user	=>	root;
	}

}

class backup::server::monthly {
	$mailto_account = "ops@wikimedia.org"
	$cycle_type = "Wikimedia-Monthly"
	$vtapes_location = "/data/amanda/Wikimedia-Monthly"
	$conf_location = "/etc/amanda/Wikimedia-Monthly"
	$tape_length = "200 gbytes"
	$tape_num = 12
	$dumpcycle = "365 days"
	$runspercycle = 1
	$tapecycle = "12 tapes"
	$incr_type = "noinc"
	$backup_priority = "low"
	$compress_type = "client best"

	file {
		"$conf_location":
			owner	=>	root,
			group	=>	root,
			mode	=>	0777,
			purge	=>	false,
			require =>	Package["amanda-server"],
			ensure	=>	directory;
		"$conf_location/amanda.conf":
			owner	=>	root,
			group	=>	root,
			mode	=>	0644,
			require	=>	File["$conf_location"],
			content	=>	template("backups/amanda-server.conf.erb");
			"$conf_location/logs":
			owner	=>	backup,
			group	=>	backup,
			mode	=>	0755,
			purge	=>	false,
			require	=>	File["$conf_location"],
			ensure	=>	directory;
		"$conf_location/index":
			owner	=>	backup,
			group	=>	backup,
			mode	=>	0755,
			purge	=>	false,
			require	=>	File["$conf_location"],
			ensure	=>	directory;
		"$conf_location/curinfo":
			owner	=>	backup,
			group	=>	backup,
			mode	=>	0755,
			purge	=>	false,
			require	=>	File["$conf_location"],
			ensure	=>	directory;
		"$conf_location/tapelist":
			owner	=>	backup,
			group	=>	backup,
			require	=>	File["$conf_location"],
			mode	=>	0644;
		"$conf_location/disklist":
			owner	=>	root,
			group	=>	root,
			mode	=>	0644,
			require =>	File["$conf_location"],
			source	=>	"puppet:///files/backup/disklist-monthly";	
	}

	exec {
		create_monthly_vtapes:
			command	=>	"/etc/amanda/create_vtapes.sh $cycle_type $tape_num $vtapes_location",
			require	=>	[ File["/etc/amanda/create_vtapes.sh"], File["$conf_location"] ],
			user	=>	root;
	}

}

class backup::client {

	define client_backup($host=$hostname, $path) {
		$line_of_text = "$host $path default"
		@@file {
			"/etc/amanda/disklist":
				owner	=>	root,
				group	=>	root,
				content =>	$line_of_text,
				tag	=>	"backup_host";
		}		
	}

	$backup_server = "tridge.wikimedia.org"
	$backup_name   = "Wikimedia-Daily"  
	$ssh_key_location = "/var/backups/.ssh/id_rsa"

	package { ["amanda-common", "amanda-client" ]:
		ensure => latest;
	}

	file {
		"/etc/amanda/":
			owner => root,
			group => root, 
			mode => 0755,
			purge => true,
			require =>	Package["amanda-client"],
			ensure => directory;
		"/etc/amanda/amanda-client.conf":
			owner => root,
			group => root,
			mode  => 0644,
			require	=> File["/etc/amanda"],
			content => template("backups/amanda-client.conf.erb");
		"/etc/amandahosts":
			owner => backup,
			group => backup,
			mode  => 0644,
			require	=> File["/etc/amanda"],
			content => template("backups/amandahosts-client.erb");
		"/var/backups/.amandahosts":
			owner => backup,
			group => backup,
			mode  => 0644,
			content => template("backups/amandahosts-client.erb");
		"/var/backups/.ssh":
			owner => backup,
			group => backup,
			mode => 0700, 
			purge => false,
			ensure =>  directory;
		"/var/backups/.ssh/authorized_keys":
			owner => backup,
			group => backup, 
			mode  => 0600,
			require => File["/var/backups/.ssh"],
			source => "puppet:///private/backup/ssh-keys/authorized_keys_client";
		"/var/backups/.ssh/id_rsa":
			owner => backup,
			group => backup,
			mode  => 0600,
			require => File["/var/backups/.ssh"],
			source => "puppet:///private/backup/ssh-keys/amanda_restore";
	}

	#service {
	#	xinetd:
	#		ensure => stopped;
	#}
}

class backup::mysql {

	include backup::client

	file {
		"/usr/local/sbin/snaprotate.pl":
			owner => root,
			group => root,
			mode  => 0755,
			source => "puppet:///files/backup/snaprotate.pl";
	}

	cron {
		snaprotate:
		command =>	"/usr/local/sbin/snaprotate.pl -a swap -V tank -s data -L 20G -c 1",
		user	=>	root,
		hour	=>	1,
		minute	=>	0;
	}

}
