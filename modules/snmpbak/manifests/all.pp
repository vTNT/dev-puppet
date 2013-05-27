class cactibase{
        package {"net-snmp":
          ensure  => present
        }
        package {"net-snmp-utils":
          ensure  => present,
          require => package["net-snmp"],
        }
        file {"snmpdiskio":
          mode    => 755,
          owner   => root,
          group   => root,
          path    => "/usr/local/bin/snmpdiskio",
          source  => "puppet:///cacti/snmpdiskio",
          require => package["net-snmp"],
        }
}

####
class cactiweb{
        include cactibase
      
        file {"webconn.sh":
          mode    => 755,
          owner   => root,
          group   => root,
          path    => "/etc/snmp/webconn.sh",
          content => template('cacti/webconn.erb'),
          require => Class["cactibase"],
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
          ensure  => running,
          enable  => true,
          subscribe => File["snmpd.conf"]
       }
}

class cactiother {
        include cactibase

       file {"snmpd.conf":
          mode    => 644,
          owner   => root,
          group   => root,
          path    => "/etc/snmp/snmpd.conf",
          content => template('cacti/snmpd-conf.erb'),
          require => Class["cactibase"],
          notify  => Service['snmpd']
       }

       service {"snmpd":
          ensure  => running,
          enable  => true,
          subscribe => File["snmpd.conf"]
       }
}
