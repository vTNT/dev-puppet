#
# mysql server 4.1 
#


class mysql-server-41 {
	package { 
		[ "mysql-server-4.1","mysql-client-4.1"]:
		ensure => installed;
	}
	
		
	file {
		"/etc/mysql/my.cnf.4.1":
		name => "/etc/mysql/my.cnf",
		source => "puppet://${fileserver}/mysql-server/my.cnf_4.1";
		"/root/.my.cnf":
		content => "[client]\npassword=${password}\n";
	}
		

#	exec { "set mysql server 4.1 root password":
#		before => File["/root/.my.cnf"],
#		subscribe => [ package["mysql-server-4.1"],package["mysql-client-4.1"]],
#		refreshonly => true,timeout => 10,
#		unless => "mysqladmin -uroot -p$password status",
#		command =>"mysqladmin -uroot password $password";
#	}
	
}

