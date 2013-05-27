node 'dns21.vmmatrix.net','dns22.vmmatrix.net','dns23.vmmatrix.net' ,'sh-zj3.tele.ldns.i.vmx.cn','sh-zj4.tele.ldns.i.vmx.cn','sh-zj5.tele.ldns.i.vmx.cn','sh-zj2.tele.idodns.i.vmx.cn','sh-zj1.tele.idodns.i.vmx.cn'{
	$corp = "vmx"
	$idc = "sh-zj"
	include dbp
	include nagios2::powerdns
	}

node 'dns123.vmmatrix.net','dns124.vmmatrix.net','sh-chj11.cnc.ldns.i.vmx.cn','sh-chj12.cnc.ldns.i.vmx.cn' {
	$corp = "vmx"
	$idc = "sh-nj"
	include dbp
	include nagios2::powerdns
	}

node 'sz-lg1.tele.dnscache.i.vmx.cn' {
	$corp = "ido"
	$idc = "sz-lg"
	include dbp
	include nagios2::powerdns
	}
	

node 'ldns1.waigao.vmmatrix.net','ldns2.waigao.vmmatrix.net','dns1.waigao.vmmatrix.net','dns2.waigao.vmmatrix.net' {
	$corp = "vmx"
	$idc = "sh-wg"
	include dbp,nagios2::powerdns
	package { ["pdns","pdns-backend-geo","pdns-backend-mysql","svk"]:ensure => installed; }
	}
