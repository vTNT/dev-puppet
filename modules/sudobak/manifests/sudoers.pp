# The 'sudo::sudoers' class ensures any sudo users specified are present in
# /etc/passwd and adds them to the group 'sudo' in /etc/group.
#
# sudo_users should be defined in the Puppet Enterprise console using a
# comma-separated list. This class will then split and manage the users' attrs.
# Alternately, the vars $::sudo_sudoers and $::sudo_sysadmins can be statically
# defined in the class definition. See the README for more information.
#
class sudobak::sudoers inherits sudobak {
  $admins   = split($sudo_sysadmins, ',')
  $sudoers  = split($sudo_sudoers, ',')

  user { [ $admins ]:
    ensure  => present,
    groups  => ['wheel'],
    require => Group['wheel'],
  }

  user { [ $sudoers ]:
    ensure  => present,
    groups  => ['sudo'],
    require => Group['wheel'],
  }

  group { "wheel":
    ensure => present,
  }

  group { "sudo":
    ensure => present,
  }
}
