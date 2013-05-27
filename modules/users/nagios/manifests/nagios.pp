#define check_process($hostname,$ip) {
#    file {"/tmp/$name":
#      content => "$hostname,$ip",
#    }
#}
##include nagios::web
########nagios client for web#############
define nagios::addservice ($webhost,$webip) {
        file {"$webhost":
          mode    => 644,
          owner   => nagios,
          group   => nagios,
          path    => "/usr/local/nagios/etc/hosts/$webhost.cfg",
          content => template('nagios/nagios_web.erb'),
 #         require => Class["nagios::web"],
          notify  => Service['nagios'],
        }

        service {"nagios":
          ensure    => running,
          enable    => true,
          subscribe => File["$webhost"],
        }
}
