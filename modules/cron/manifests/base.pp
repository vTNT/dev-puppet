class cron::base {
        package {"cron":
          name => $operatingsystem ?{
            centos => "vixie-cron"
          },
          ensure => present,
        }
        service {"crond":
          name => $operatingsystem ?{
                centos => "crond"
          },
          ensure => running,
          enable => true,
          pattern => cron,
          require => package["cron"],
        }
}
