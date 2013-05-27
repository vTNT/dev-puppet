# rji-sudo
A Puppet module to manage sudoers on Enterprise Linux.
https://github.com/rji/puppet-sudo

*Note: This module was developed for and has only been tested on Enterprise Linux. Additional operating systems and releases may be added in the future.*

## Overview:
The 'rji-sudo' module maintains a secure sudoers configuration. It performs the following:

1. Sources a sudoers file from the Puppet Master
2. Maintains users in the 'wheel' and 'sudo' groups
3. Purges any configuration files found in /etc/sudoers.d
4. Modifies PAM's `su` module to disable `/sbin/su` for users not in the group `wheel`

## Prerequisites:
*  A working Puppet master/node deployment
*  CentOS, RHEL, or another Enterprise Linux in the 6.x family

## Usage:
### Puppet (with Console/Dashboard):
1. Create two console parameters, per-node or per-group:
    1. `sudo_sysadmins`
    2. `sudo_sudoers`
2. Each parameter should contain a comma-separated list (no whitespace) of users that should be in each group.
3. Add the class to the Console/Dashboard and apply it to a node or node group.
4. That's it!

### Puppet (without Dashboard):
In the file that you configure node definitions (such as site.pp), define the following, either per-host or per-group:

    node 'host.example.com' {
      class { "sudo":
        sudo_sysadmins => ['sradmin1','sradmin2']
        sudo_sudoers   => ['jradmin1','jradmin2']
    }

## Caveats
As distributed, this module will *not* make group membership inclusive, meaning all of a user's existing groups _will be preserved_. If you want to reverse this behavior, modify the `user` type in `sudoers.pp` to reflect the following:

    user { [ $admins ]:
      ensure     => present,
      groups     => ['wheel'],
      membership => inclusive,
      require    => Group['wheel'],
    }

## Testing and Validation
There is a built-in test in the `tests/` directory. It can be modified as needed and called with the following command (assuming you are in this module's directory):

    [root@xps ~/working/sudo]# puppet apply --verbose --noop --modulepath ../ tests/init.pp

If everything went well, you should see output similar to the following:

    notice: /Stage[main]/Sudo::Conf/File[/etc/sudoers]/ensure: current_value absent, should be file (noop)
    notice: /Stage[main]/Sudo::Sudoers/User[test-wheel-1]/ensure: current_value absent, should be present (noop)
    notice: /Stage[main]/Sudo::Sudoers/User[test-wheel-2]/ensure: current_value absent, should be present (noop)
    notice: /File[/etc/sudoers.d/evil-config]/ensure: current_value file, should be absent (noop)
    notice: /etc/sudoers.d: Would have triggered 'refresh' from 1 events
    notice: Class[Sudo::Conf]: Would have triggered 'refresh' from 2 events
    notice: /Stage[main]/Sudo::Sudoers/User[test-sudo-1]/ensure: current_value absent, should be present (noop)
    notice: Class[Sudo::Sudoers]: Would have triggered 'refresh' from 3 events
    notice: Stage[main]: Would have triggered 'refresh' from 2 events
    notice: Finished catalog run in 0.21 seconds

This can be verified with a quick check of `/etc/sudoers` and `/etc/group`.
