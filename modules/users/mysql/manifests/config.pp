class mysql::config{
    file {"/etc/my.cnf":
        source  => "puppet:///modules/mysql/my.cnf",
        require => Class["mysql::install"],
	      notify  => Class["mysql::service"],
    }
}
