class users::virtual {
        @user { "sky":
            ensure  => present,
            uid     => "3001",
            comment => "test by sky",
            shell   => "/bin/bash",
            managehome  => true,
        }
}
