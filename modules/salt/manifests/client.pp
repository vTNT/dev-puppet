class salt::client inherits salt::base {
        file {"minion":
          content => template("salt/minion.erb"),
          owner   => root,
          group   => root,
          mode    => 640,
          path    => "/etc/salt/minion",
          notify  => Service["salt-minion"],
        }

        service {"salt-minion":
          ensure    => running,
          enable    => true,
          subscribe => File["minion"],
        }
}
