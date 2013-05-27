class nginx::install {
    package {"nginx-stable":
        ensure => present,
    }
}
