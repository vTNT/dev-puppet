puppet-firewall
===============

My infrastructure setup is pretty simple: all of our VMs are behind a hardware firewall, but I want the added security of iptables running on each individual VM.  Generally, I leave only 22/tcp (SSH) and 161/udp (SNMP) open, and otherwise specify an array of other TCP or UDP ports to open within the node definition.

This is the simplest Puppet module I could come up with.

Usage
-----

Sepcify an array of ports to open in '*open_tcp*' or '*open_udp*' parameters to the 'firewall' class.

A node definition will look like this:

    node
        'testvm.company.com'
    inherits default {
        class {
            # Here's the magic
            firewall:
                open_tcp => [ "80", "443" ];
    
            # Other class definitions here...
            app::example:
                docroot  => "/var/www/example",
                gitrepo  => "github:sschneid/example.git";
        }
    }

