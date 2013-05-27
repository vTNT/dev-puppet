puppet-sudo
===========

for puppet sudo module

os:centos 5.8
===========

puppet version:2.7.20
===========

Usage
==========

at site.pp

    node 'host.example.com' {
        include sudo
        sudo::soduers { "example":
            sudo_sysadmins => ['sradmin1','sradmin2'],
            sudo_sudoers   => ['jradmin1','jradmin2'],
        }
    }
