# init.pp

class firewall (
    $ensure = "running",
    $autoupdate = false,

    $custom = "UNSET",

    $open_udp = "",
    $open_tcp = ""
) {

    include iptables

    if ! ( $ensure in [ "running", "stopped" ] ) {
        fail( "ensure parameter must be 'running' or 'stopped'" )
    }

    if ( $autoupdate == true ) {
        $package_ensure = latest
    } elsif ( $autoupdate == false ) {
        $package_ensure = present
    } else {
        fail( "autoupdate parameter must be 'true' or 'false'" )
    }

    if ( $custom == "UNSET" ) {
        file {
            "/etc/sysconfig/iptables":
                ensure => file,
                owner => 0,
                group => 0,
                mode => 600,
                content => template( "${module_name}/iptables.erb" ),
                notify => Service[ "iptables" ];
        }
    } else {
        file {
            "/etc/sysconfig/iptables":
                ensure => file,
                owner => 0,
                group => 0,
                mode => 600,
                source => "puppet://${servername}/modules/${module_name}/${::fqdn}",
                notify => Service[ "iptables" ];
        }
    }

}

