class cacti::db inherits cacti {

       file {"snmpd.conf":
          mode    => 644,
          owner   => root,
          group   => root,
          path    => "/etc/snmp/snmpd.conf",
          content => template('cacti/snmpd-conf.erb'),
          notify  => Service['snmpd'],
       }

       service {"snmpd":
          ensure  => running,
          enable  => true,
          subscribe => File["snmpd.conf"],
       }
}
