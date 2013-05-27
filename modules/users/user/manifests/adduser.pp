class user::adduser {
      @user {"xx":
        ensure  => present,
        shell   => "/bin/bash",
        tag     => ['abc','a'],
        groups  => dev,
        require => Group['dev'],
        managehome  => true,
      }

      @user {"c":
        ensure  => present,
        tag     => ['abc'],
      }

      group {"dev":
        ensure  => present,
      }
}

