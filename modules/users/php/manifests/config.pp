class php::config{
    file {
        "/etc/php.ini":
        source => "puppet:///modules/php/php.ini",
        require => Class["php::install"],
	notify => Class["php::service"],
    }

    file {
        "/etc/php-fpm.conf":
        source => "puppet:///modules/php/php-fpm.conf",
        require => Class["php::install"],
        notify => Class["php::service"],
    }

    file {
        "/etc/php-fpm.d/www.conf":
        source => "puppet:///modules/php/www.conf",
        require => Class["php::install"],
        notify => Class["php::service"],
    }

}
