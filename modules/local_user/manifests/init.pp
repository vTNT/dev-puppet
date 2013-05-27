# This is an example of a pattern and as such may not be ideally
# suited to any particular environment out-of-the-box, but it can
# be taken and modified to fit many scenarios that require
# machine-local accounts to be created with details that differ
# from machine to machine.
define local_user (
  $uid,
  $gid,
  $shell   = undef,
  $groups  = undef,
  $ensure  = 'present',
  $comment = 'User &'
) {

  # If the user already exists, we will not manage the password.
  # If the user doesn't exist, we will create it with a random
  # password. The custom fact local_users is used to determine 
  # whether or not the user has already been created at the time
  # of the current Puppet run.
  $user_exists = $title in split($::local_users, ',')

  # How the new random password gets set can be accomplished any
  # number of ways. This is not the only possibility.
  $password = $user_exists ? {
    true  => undef,
    false => generate(
      '/bin/sh',
      '-c',
      'tr -dc A-Za-z0-9 < /dev/urandom | head -c8'
    ),
  }

  # Create the user
  user { $title:
    ensure   => $ensure,
    gid      => $gid,
    groups   => $groups,
    comment  => $comment,
    shell    => $shell,
    uid      => $uid,
    password => $password,
  }

  # Do SOMETHING to notify the user of the new randomly generated
  # password. A custom function could be used to generate an email
  # message, for example. Here, we're simply creating a notify 
  # resource for the report.
  if $password {
    notify { "$title user password set":
      message => "password for user $title on $::certname has been set to: $password",
    }
  }

}
