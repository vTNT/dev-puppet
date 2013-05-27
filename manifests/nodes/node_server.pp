node 'func.domain.com' {
        #include nagios
      #  nagios::addservice {"add nagios server":
      #    webhost   => "xm-redis-web",
      #    webip     => "192.168.10.11",
      #  }
      @@file { "/tmp/file11":
        content => "xxx",
        tag     => "bb",
      }
}
