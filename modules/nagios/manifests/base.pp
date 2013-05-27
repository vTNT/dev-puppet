class nagios::base (
  $nagiospluginsversion="1.4.16-10",
  $nrpe_version="2.13-10"
){ 
        package {"xinetd":
          ensure  => present,
        }
        
        package {"nagios-plugins":
          ensure  => $nagiospluginsversion,
        }

        package {"nrpe":
          ensure  => $nrpe_version,
          require => Package["nagios-plugins"],
        }

        file {"nrpe.cfg":
          mode      => 0644,
          owner     => nagios,
          group     => nagios,
          path      => "/usr/local/nagios/etc/nrpe.cfg",
          require   => Package["nrpe"],
          content   => template('nagios/base-nrpe-cfg.erb'),
          notify    => Service['xinetd'],  
        }

        file {"nrpe":
          mode      => 0644,
          owner     => root,
          group     => root,
          path      => "/etc/xinetd.d/nrpe",
          content   => template('nagios/nrpe.erb'),
          require   => Package["nrpe"],
          notify    => Service['xinetd'],
        }
      
        service {"xinetd":
          ensure    => running,
          enable    => true,
          subscribe => File["nrpe","nrpe.cfg"],
        }
}
