#
#  for internal autodns
#
#	sz-lg	tele
node 'sz-lg3.tele.dnscache.i.vmx.cn','sz-lg2.tele.dnscache.i.vmx.cn' {
	$corp="ido"
	$idc="sz-lg"
	$nettype="tele"
	$mirrorserver="10.2.255.251"
	$vmxpackageserver="127.0.0.1:81"
	
	include dbp,internalautodns,nagios2::powerdns
	}

node 'sh-zj1.tele.dnscache.i.vmx.cn','sh-zj2.tele.dnscache.i.vmx.cn' {
	$corp="vmx"
	$idc="sh-zj"
	$nettype="tele"
	include dbp,internalautodns,nagios2::powerdns
	}
#
#  for external autodns
#
node  	'sh-zj1.tele.idns.i.vmx.cn','sh-zj2.tele.idns.i.vmx.cn'{
	$nettype="tele"
	$nagiosid="sh-zj"
	$idc="sh-zj"
	include dbp,externalautodns
	}


node	'sz-lg1.tele.idns.i.vmx.cn','sz-lg2.tele.idns.i.vmx.cn' {

	$vmxpackageserver="10.101.8.199"
	$nettype="tele"
	$nagiosid="sz-lg"
	$idc="sz-lg"

	include dbp,externalautodns
	}

node  	'sh-nj1.cm.idns.i.vmx.cn','sh-nj2.cm.idns.i.vmx.cn' {
	$nettype="tele"
	$nagiosid="sh-nj"
	$idc="sh-nj"
	include dbp,externalautodns
	}

node  	'sh-nj3.cm.idns.i.vmx.cn','sh-nj4.cm.idns.i.vmx.cn' {
	$nettype="cnc"
	$nagiosid="sh-nj"
	$idc="sh-nj"
	include dbp,externalautodns
	}

node   'ln-sy2.cnc.idns.i.vmx.cn','ln-sy1.cnc.idns.i.vmx.cn'{
	$mirrorserver="mirrors.kernel.org"
	$vmxpackageserver="10.0.66.191"
	$nettype="cnc"
	$nagiosid="ln-sy"
	$idc="ln-sy"

	include dbp,externalautodns
	}

node 'm2.us.i.vmx.cn' {
	$mirrorserver="mirrors.kernel.org"
	$vmxpackageserver="10.0.7.2"
	$nettype="cnc"
	$nagiosid="us-m2"
	$idc="sh-zj"

	include dbp,externalautodns
	}



node 'bindus4.vmmatrix.net' {
	$nettype="cnc"
	$nagiosid="us-m4"
	$idc="us-m4"
	$fileserver = "sh-zj1.tele.trac.i.vmx.cn"
	$mirrorserver = "ftp.debian.org"
	include dbp
	}
