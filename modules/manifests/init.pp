# rji-sudo
# A Puppet module to manage sudoers and sysadmins on Enterprise Linux.
# https://github.com/rji/puppet-sudo
#
# Class:sudo
# This class is the fully-qualified 'sudo' class. It determines if the module
# can be executed on the target node.
#
class sudo {
  case $::osfamily {
    'RedHat': {
      include "sudo::conf"
      import 'sudoers.pp'
    }
    default: {
      fail("$::osfamily not yet supported by the 'sudo' module!")
    }
  }
}
