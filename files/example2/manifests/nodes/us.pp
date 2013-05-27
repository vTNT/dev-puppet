#############   us dns ######################
node 'cdn-ns3.vmmatrix.net','cdn-ns4.vmmatrix.net','ns19.vmmatrix.net' {
	$fileserver = "sh-zj1.tele.trac.i.vmx.cn"
	$mirrorserver = "ftp.debian.org"
	$corp="vmx"
	$idc="sh-zj"
	include dbp
	include nagios2::powerdns
	nagios2::service { "${fqdn}_mysqlrep": check_command => "check_mysql_replication";}
	}

node 'ns11.vmmatrix.net' {
	$fileserver = "sh-zj1.tele.trac.i.vmx.cn"
	$mirrorserver = "ftp.debian.org"
	$cache_mem="512"
	$corp="vmx"
	$ipaddress="10.0.181.1"
	$idc="sh-zj"
	$cache_dirs="
cache_dir null /tmp "
	$proxydnstype="vmx"
	include dbp
	include metasquid
	include proxydns
	nagios2::service { "${fqdn}_mysqlrep": check_command => "check_mysql_replication";}
	}


############## us squid ################
node 'squid-us4.vmmatrix.net' {
	$fileserver = "sh-zj1.tele.trac.i.vmx.cn"
	$mirrorserver = "ftp.debian.org"
	$cache_mem="256"
	$corp="vmx"
	$idc="sh-zj"
	$proxydnstype="vmx"
	$cache_dirs="
cache_dir ufs /squid_cache2 75000 32 32"
	include dbp
	include metasquid
	include proxydns
	}


node 'squid_us9.vmmatrix.net' {
	$fileserver = "sh-zj1.tele.trac.i.vmx.cn"
	$mirrorserver = "ftp.debian.org"
	$cache_mem="256"
	$corp="vmx"
	$idc="sh-zj"
	$proxydnstype="vmx"
	$cache_dirs="
cache_dir ufs /squid_cache2 118000 32 32"
	include dbp
	include metasquid
	include proxydns
	}

