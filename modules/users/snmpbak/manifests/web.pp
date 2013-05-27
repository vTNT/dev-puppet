####
class cacti::web inherits cacti {
        file {"webconn.sh":
          mode    => 755,
          owner   => root,
          group   => root,
          path    => "/etc/snmp/webconn.sh",
          content => template('cacti/webconn.erb'),
          notify  => File["snmpd.conf"],
        }

       file {"snmpd.conf":
          mode    => 644,
          owner   => root,
          group   => root,
          path    => "/etc/snmp/snmpd.conf",
          content => template('cacti/snmpd-web-conf.erb'),
          require => File["webconn.sh"],
          notify  => Service['snmpd']
       }

       service {"snmpd":
          ensure    => running,
          enable    => true,
          subscribe => File["snmpd.conf"]
       }
}
