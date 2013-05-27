define user::deluser (
        $username
        )
        {
          user {"$username":
            ensure  => absent,
        }
          file {"/home/$username":
            ensure  => absent,
          }
}
