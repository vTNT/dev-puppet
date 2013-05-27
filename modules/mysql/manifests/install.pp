class mysql::install {
    package {[
      "MySQL-client",
      "MySQL-devel",
      "MySQL-server",
      "MySQL-shared",
      "MySQL-shared-compat"]:
        ensure => present,
    }
}
