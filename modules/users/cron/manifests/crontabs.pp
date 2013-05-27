class cron::crontabs {
        package {"crontabs":
            name => $operatingsystem ?{
              centos => "crontabs"
            },
            ensure => present,
        }
}

