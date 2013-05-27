node 'squid143.vmmatrix.net' {
	$fileserver="sh-zj1.tele.trac.i.vmx.cn"
	$cache_dirs="
cache_dir aufs /squid_cache 1024 32 256"
	$cache_mem="768"
	$corp="vmx"
	$idc="sh-nj"
	include dbp
	include frontsquid
	}

