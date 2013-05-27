node default {
        include user
        realize user['c']

        user::deluser{"userdel kk":
          username  => kk,
        }

        User <| groups == dev |>
}
