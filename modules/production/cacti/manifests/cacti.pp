class cacti{
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
          source  => "puppet:///modules/cacti/snmpdiskio",
          require => package["net-snmp"],
        }
}
