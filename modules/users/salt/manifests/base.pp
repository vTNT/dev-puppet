class salt::base {
        package {"salt":
          ensure => present,
        }
        package {"salt-minion":
          ensure  => present,
          require => package["salt"],
        }
}
