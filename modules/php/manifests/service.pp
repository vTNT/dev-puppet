class php::service{
    service {
        "php-fpm":
        ensure => running,
	hasstatus => true,
	hasrestart => true,
	enable => true,
	require => Class["php::config"],
    }
}
