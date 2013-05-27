node 'mysqlapi8.vmmatrix.net','mysqlapi9.vmmatrix.net','mysqlapi7.vmmatrix.net' {
	$mirrorserver = "10.2.255.251"
	$corp = "vmx"
	$idc = "sh-zj"
	include dbp
	include nagios2::mysqlrep
	}

node 'mysqlapi12.vmmatrix.net','mysqlapi11.vmmatrix.net' {
	$corp = "vmx"
	$idc = "sh-nj"
	include dbp
	include nagios2::mysqlrep
	}


node 'db1.waigao.vmmatrix.net','db2.waigao.vmmatrix.net'{
	$corp = "vmx"
	$idc = "sh-wg"
	include dbp,nagios2::mysqlrep
	}
