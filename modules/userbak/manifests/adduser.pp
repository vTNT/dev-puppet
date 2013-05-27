    define user::adduser ($username,$group,$password)
    {
            user {"$username":
              shell => "/bin/bash",
            #  group => $group,
              require => Group["$group"],
              password  => $password,
            }
            group {"$group":
              ensure  => present,
            }
    }
