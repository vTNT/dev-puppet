class nagios::test inherits nagios {
        file {"/root/test":
          owner => nagios,
          group => nagios,
          ensure  => directory,
        }
}
