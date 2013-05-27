node	'ln-sy1.cnc.ldns.i.vmx.cn', 'ln-sy2.cnc.ldns.i.vmx.cn',	'ln-sy3.cnc.ldns.i.vmx.cn', 'ln-sy4.cnc.ldns.i.vmx.cn'	{
	$proxydnstype="vmx"
	$corp = "vmx"
	$idc = "sh-nj"
	include dbp
	include proxydns
	include nagios2::powerdns
	
}

