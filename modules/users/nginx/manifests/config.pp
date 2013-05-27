class nginx::config{
    file {
        "/etc/nginx/nginx.conf":
        source => "puppet:///modules/nginx/nginx.conf",
        require => Class["nginx::install"],
	      notify => Class["nginx::service"],
    }

    file {
        "/etc/nginx/fcgi.conf":
        source => "puppet:///modules/nginx/fcgi.conf",
        require => Class["nginx::install"],
        notify => Class["nginx::service"],
    }
}
