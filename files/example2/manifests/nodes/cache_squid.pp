# most importent file
#
# for all squid server. 
#

###########################################
## 	vmx sh-nj
###########################################

node 'squid120.vmmatrix.net' {
	$cache_dirs="
cache_dir ufs /squid_cache2 17500 32 32
cache_dir ufs /squid_cache3 17500 32 32"
	$corp="vmx"
	$idc="sh-nj"
	include dbp
	include behindsquid
	}


node 'squid102.vmmatrix.net','squid103.vmmatrix.net' {
	$cache_dirs="
cache_dir ufs /squid_cache2 17500 64 64
cache_dir ufs /squid_cache3 17500 64 64"
	$corp="vmx"
	$idc="sh-nj"
	include dbp
	include behindsquid
	}
	
node 'squid131.vmmatrix.net' {
	$cache_dirs="
cache_dir ufs /squid_cache2 17500 64 64
cache_dir ufs /squid_cache4 70000 64 64
cache_dir ufs /squid_cache3 52224 64 128"
	$corp="vmx"
	$idc="sh-nj"
	include dbp
	include behindsquid
	}
	
node 'squid132.vmmatrix.net' {
	$cache_dirs="
cache_dir ufs /squid_cache2 102400 64 128"
	$corp="vmx"
	$idc="sh-nj"
	include dbp
	include behindsquid
	}

node 'squid135.vmmatrix.net','squid139.vmmatrix.net','squid137.vmmatrix.net' {
	$cache_dirs="
cache_dir ufs /squid_cache2 52224 64 128
cache_dir ufs /squid_cache3 52224 64 128"
	$corp="vmx"
	$idc="sh-nj"
	include dbp
	include behindsquid
	}

node 'squid124.vmmatrix.net','squid145.vmmatrix.net' {
	$cache_dirs="
cache_dir ufs /squid_cache2 60000 64 128
cache_dir ufs /squid_cache3 60000 64 128"
	$corp="vmx"
	$idc="sh-nj"
	include dbp
	include behindsquid
	}

node 'squid126.vmmatrix.net' {
	$cache_dirs="
cache_dir ufs /squid_cache2 70000 64 128
cache_dir ufs /squid_cache3 50000 64 128"
	$corp="vmx"
	$idc="sh-nj"
	include dbp
	include behindsquid
	}

###########################################
## 	ido sz-lg
###########################################


node 'sz-lg2.tele.idosquid.i.vmx.cn','sz-lg4.tele.idosquid.i.vmx.cn','sz-lg6.tele.idosquid.i.vmx.cn','sz-lg8.tele.idosquid.i.vmx.cn','sz-lg10.tele.idosquid.i.vmx.cn' {
	$cache_dirs="
cache_dir ufs /squid_cache2  27000 64 64
cache_dir ufs /squid_cache3  27000 64 64"
	$corp="ido"
	$idc="sz-lg"
	include dbp
	include behindsquid
	file { "/etc/resolv.conf":
		content => "nameserver 10.101.8.103\nnameserver 10.101.8.102\noptions timeout:3\n";
		}
	}


###########################################
## 	vmx sh-zj
###########################################



node 'squid5.vmmatrix.net' {
	$cache_dirs="
cache_dir aufs /squid_cache2 21000 32 256
cache_dir aufs /squid_cache3 15750 32 256
cache_dir aufs /squid_cache4 15750 32 256"
	$corp="vmx"
	$idc="sh-zj"
	include dbp
	include behindsquid
	}
	
node 'squid4.vmmatrix.net' {
	$cache_dirs="
cache_dir aufs /squid_cache2 44000 32 256
cache_dir aufs /squid_cache3 44000 32 256"
	$corp="vmx"
	$idc="sh-zj"
	include dbp
	include behindsquid
	}

node 'squid10.vmmatrix.net' {
	$cache_dirs="
cache_dir aufs /squid_cache2 17500 32 256
cache_dir aufs /squid_cache3 17500 32 256"
	$corp="vmx"
	$idc="sh-zj"
	include dbp
	include behindsquid
	}

node 'squid1.vmmatrix.net' {
	$cache_dirs="
cache_dir aufs /squid_cache2 38500 32 256
cache_dir aufs /squid_cache3 19500 32 256"
	$corp="vmx"
	$idc="sh-zj"
	include dbp
	include behindsquid
	}


node 'squid51.vmmatrix.net' {
	$cache_dirs="
cache_dir aufs /squid_cache2 146000 32 256"
	$corp="vmx"
	$idc="sh-zj"
	include dbp
	include behindsquid
	}



node 'squid12.vmmatrix.net' {
	$cache_dirs="
cache_dir aufs /squid_cache2 17500 32 256
cache_dir aufs /squid_cache3 15000 32 256
cache_dir aufs /squid_cache4 13000 32 256
cache_dir aufs /squid_cache5 17500 32 256"
	$corp="vmx"
	$idc="sh-zj"
	include dbp
	include behindsquid
	}

node 'squid14.vmmatrix.net' {
	$cache_dirs="
cache_dir aufs /squid_cache2 60000 32 256
cache_dir aufs /squid_cache3 60000 32 256"
	$corp="vmx"
	$idc="sh-zj"
	include dbp
	include behindsquid
	}

node 'squid18.vmmatrix.net' {
	$cache_dirs="
cache_dir aufs /squid_cache2 54000 32 256
cache_dir aufs /squid_cache3 15000 32 256"
	$corp="vmx"
	$idc="sh-zj"
	include dbp
	include behindsquid
	}


node 'squid22.vmmatrix.net','squid19.vmmatrix.net' {
	$cache_dirs="
cache_dir aufs /squid_cache2 17500 32 256
cache_dir aufs /squid_cache3 17500 32 256"
	$corp="vmx"
	$idc="sh-zj"
	include dbp
	include behindsquid
	}



################# ln-sy (just for nagios test)#######################

node 'ln-sy1.cnc.squid.i.vmx.cn','ln-sy4.cnc.squid.i.vmx.cn' {
	$corp="vmx"
	$idc="sh-nj"
	include dbp
	include nagios2::squid
}


node 'cache_squid11.waigao.vmmatrix.net' {
	$cache_dirs="
cache_dir aufs /squid_cache2 115000 32 256"
	$corp = "vmx"
	$idc = "sh-wg"
	include dbp,behindsquid
	}
node 'cache_squid12.waigao.vmmatrix.net','cache_squid13.waigao.vmmatrix.net','cache_squid14.waigao.vmmatrix.net' {
	$cache_dirs="
cache_dir aufs /squid_cache2 135000 32 256"
	$corp = "vmx"
	$idc = "sh-wg"
	include dbp,behindsquid
	}
