# This class sources and maintains necessary files and packages.
#
class sudo::conf {
  package { "sudo":
    ensure => present,
  }

  # Source the sudoers file from the Puppet Master
  file { "/etc/sudoers":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 0440,
    source  => "puppet:///modules/sudo/sudoers",
    require => Package["sudo"],
  }

  # Source a new 'su' file for PAM (caution: this may be platform-specific)
  file { "/etc/pam.d/su":
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => 0644,
    source => "puppet:///modules/sudo/pam_su_el6"
  }

  # Clear any config in sudoers.d
  file { "/etc/sudoers.d":
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0750',
    recurse => true,
    purge   => true,
    require => Package["sudo"],
  }
}
