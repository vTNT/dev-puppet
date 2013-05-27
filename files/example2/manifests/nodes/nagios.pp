#
# monitor squid ,dns and mysql server.
#
node  	'ln-sy1.cnc.nagios.i.vmx.cn','sh-nj2.cm.nagios.i.vmx.cn' {
	include dbp
	}

node  	'sh-zj1.tele.nagios.i.vmx.cn' {
	include dbp
	include nagios2center,cacticenter
	# internet host
	include internet_sh_nj_host
	include internet_sz_lg_host
	include internet_sh_zj_host
	}

node  	'sh-nj4.cm.nagios.i.vmx.cn' {
	$fileserver = "sh-zj1.tele.trac.i.vmx.cn"
	include dbp
	include nagios2center,cacticenter
	# internet host
	include internet_sh_nj_host
	include internet_sz_lg_host
	include internet_sh_zj_host
	}

node 'nagioscenter.i.vmx.cn' {
	include dbp
	include apache2
	}

node 'sh-zj3.tele.nagios.i.vmx.cn' {
	$corp = "vmx"
	$idc = "sh-zj"
	$nettype ="tel"

	include dbp
	include nagios2
	include cacti
	include internet_sh_nj_host
	include internet_sz_lg_host
	}
node 'sh-nj1.cm.nagios.i.vmx.cn' {
	$corp = "vmx"
	$idc = "sh-nj"
	$nettype = "cnc"
	include dbp,vsftpd
	include nagios2
	include cacti
	include internet_sh_zj_host
	include internet_sz_lg_host
	}
node 'sz-lg1.tele.nagios.i.vmx.cn' {
	$corp = "ido"
	$idc = "sz-lg"
	$nettype = "tel"
	include dbp
	include nagios2
	include cacti
	include internet_sh_zj_host
	include internet_sh_nj_host
	}

node 'nagios1.waigao.vmmatrix.net' {
	$corp = "vmx"
	$idc = "sh-wg"
	$nettype = "tel"
	include dbp,nagios2,cacti
	}
