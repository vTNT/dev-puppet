################################################
#        SH-NJ 
################################################
class internet_sh_nj_host {
	nagios2::internet_cache {
                "cache.221.130.180.167":ip => "221.130.180.167";
                "cache.221.130.180.220":ip => "221.130.180.220";
	}
	nagios2::internet_dns {
                "dns.221.130.180.168":ip => "221.130.180.168";
                "dns.75.101.148.47":ip => "75.101.148.47";
                "dns.67.19.118.163":ip => "67.19.118.163";
                "dns.66.240.238.120":ip => "66.240.238.120";
                "dns.216.75.20.186":ip => "216.75.20.186";
                "dns.221.130.180.165":ip => "221.130.180.165",checkdomain => "sh-zj.cache.tele.vmmatrix.com";
	}
	file {
		"/etc/nagios/target/internet/dns.67.202.55.72.cfg": ensure => absent;
	}
}



################################################
#        SH-ZJ 
################################################
class internet_sh_zj_host {
	file {
		"/etc/nagios/target/internet/cache.61.172.246.166.cfg": ensure => absent;
		"/etc/nagios/target/internet/cache.61.172.246.167.cfg": ensure => absent;
		"/etc/nagios/target/internet/cache.61.172.246.168.cfg": ensure => absent;
		"/etc/nagios/target/internet/cache.61.172.246.169.cfg": ensure => absent;
	}
	nagios2::internet_cache {
                "cache.61.172.246.170":ip => "61.172.246.170";
                "cache.61.172.246.172":ip => "61.172.246.172";
	}
	nagios2::internet_dns {
                "dns.61.172.246.171":ip => "61.172.246.171";
                "dns.61.172.246.166":ip => "61.172.246.166",checkdomain => "sh-zj.cache.tele.vmmatrix.com";
	}
}



################################################
#        SZ-LG
################################################
class internet_sz_lg_host {
	nagios2::internet_cache {
                "cache.58.61.157.28":ip => "58.61.157.28";
                "cache.58.61.157.241":ip => "58.61.157.241";
                "cache.58.61.155.14":ip => "58.61.155.14";
                "cache.121.11.92.181":ip => "121.11.92.181";
	}
	nagios2::internet_dns {
                "dns.58.61.155.5":ip => "58.61.155.5",checkdomain => "sz-lg.cache.tele.vmmatrix.com";
	}
}
