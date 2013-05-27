#define roles

class vmx_sh_zj_carp_squid {
	$corp="vmx"
	$idc="sh-zj"

	include dbp,frontsquid
	}

class vmx_sh_nj_carp_squid {
	$corp="vmx"
	$idc="sh-nj"

	include dbp,frontsquid
	}

class ido_sz_lg_carp_squid {
	$corp="ido"
	$idc="sz-lg"

	include dbp,frontsquid

	file { "/etc/resolv.conf":
		content => "nameserver 10.101.8.102\nnameserver 10.101.8.103\noptions timeout:3\n";
		}
	}

class vmx_sh_wg_carp_squid {
	$corp="vmx"
	$idc="sh-wg"

	include dbp,frontsquid
	file { "/etc/resolv.conf":
		content => "nameserver 10.0.97.191\nnameserver 10.0.97.192\noptions timeout:3\n";
		"/etc/network/if-up.d/static-route":
		mode => 0755,
		source => "puppet://$fileserver/vmxsquid/$corp/$idc/static-route";
		}
	}
