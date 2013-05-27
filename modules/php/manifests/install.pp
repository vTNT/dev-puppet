class php::install {
    package {[
        "php",
	"php-cli",
	"php-common",
	"php-devel",
	"php-fpm",
	"php-gd",
	"php-mbstring",
	"php-mcrypt",
	"php-mysql",
	"php-pdo",
	"php-pear",
	"php-redis",
	"php-xml",
	"php-xmlrpc"]:
        ensure => installed;
    }
}
