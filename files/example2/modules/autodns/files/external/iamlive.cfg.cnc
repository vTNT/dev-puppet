## test
define hostgroup{
        hostgroup_name  iamlive
        alias           I'am live test 
        members         localhost
        }


##

define host {
	host_name	host.218.25.59.253
	address		218.25.59.253
	use		active_linux_server
	hostgroups	iamlive
}

define service {
	service_description	check_ping
	use			active_service
	host_name		host.218.25.59.253
        obsess_over_service     0
	check_command		check_ping!500,50%!500,80%
}

define host {
	host_name	host.210.22.70.3
	address		210.22.70.3
	use		active_linux_server
	hostgroups	iamlive
}

define service {
	service_description	check_ping
	use			active_service
	host_name		host.210.22.70.3
        obsess_over_service     0
	check_command		check_ping!500,50%!500,80%
}

define host {
	host_name	host.210.22.70.227
	address		210.22.70.227
	use		active_linux_server
	hostgroups	iamlive
}

define service {
	service_description	check_ping
	use			active_service
	host_name		host.210.22.70.227
        obsess_over_service     0
	check_command		check_ping!500,50%!500,80%
}


define host {
	host_name	host.202.96.199.133
	address		202.96.199.133
	use		active_linux_server
	hostgroups	iamlive
}

define service {
	service_description	check_ping
	use			active_service
	host_name		host.202.96.199.133
        obsess_over_service     0
	check_command		check_ping!500,50%!500,80%
}

define host {
	host_name	host.210.52.149.2
	address		210.52.149.2
	use		active_linux_server
	hostgroups	iamlive
}

define service {
	service_description	check_ping
	use			active_service
	host_name		host.210.52.149.2
        obsess_over_service     0
	check_command		check_ping!500,50%!500,80%
}

define host {
	host_name	host.210.53.31.2
	address		210.53.31.2
	use		active_linux_server
	hostgroups	iamlive
}

define service {
	service_description	check_ping
	use			active_service
	host_name		host.210.53.31.2
        obsess_over_service     0
	check_command		check_ping!500,50%!500,80%
}

define host {
	host_name	host.210.52.207.2
	address		210.53.31.2
	use		active_linux_server
	hostgroups	iamlive
}

define service {
	service_description	check_ping
	use			active_service
	host_name		host.210.52.207.2
        obsess_over_service     0
	check_command		check_ping!500,50%!500,80%
}


define host {
	host_name	www.google.cn
	address		www.google.cn
	use		active_linux_server
	hostgroups	iamlive
}

define service {
	service_description	check_ping
	use			active_service
	host_name		www.google.cn
        obsess_over_service     0
	check_command		check_ping!500,50%!500,80%
}

define host {
	host_name	www.taobao.com
	address		www.taobao.com
	use		active_linux_server
	hostgroups	iamlive
}

define service {
	service_description	check_ping
	use			active_service
	host_name		www.taobao.com
        obsess_over_service     0
	check_command		check_ping!500,50%!500,80%
}

define host {
	host_name	www.sina.com.cn
	address		www.sina.com.cn
	use		active_linux_server
	hostgroups	iamlive
}

define service {
	service_description	check_ping
	use			active_service
	host_name		www.sina.com.cn
        obsess_over_service     0
	check_command		check_ping!500,50%!500,80%
}

define host {
	host_name	www.qq.com
	address		www.qq.com
	use		active_linux_server
	hostgroups	iamlive
}

define service {
	service_description	check_ping
	use			active_service
	host_name		www.qq.com
        obsess_over_service     0
	check_command		check_ping!500,50%!500,80%
}

define host {
	host_name	www.baidu.com
	address		www.baidu.com
	use		active_linux_server
	hostgroups	iamlive
}

define service {
	service_description	check_ping
	use			active_service
	host_name		www.baidu.com
        obsess_over_service     0
	check_command		check_ping!500,50%!500,80%
}

  

# cluseter check

define service {
	service_description	check_iamlive
        obsess_over_service     0
	check_command		check_service_cluster!"iamlive"!9!9!$SERVICESTATEID:host.218.25.59.253:check_ping$,$SERVICESTATEID:host.210.22.70.3:check_ping$,$SERVICESTATEID:host.210.22.70.227:check_ping$,$SERVICESTATEID:host.202.96.199.133:check_ping$,$SERVICESTATEID:host.210.52.149.2:check_ping$,$SERVICESTATEID:host.210.53.31.2:check_ping$,$SERVICESTATEID:host.210.52.207.2:check_ping$,$SERVICESTATEID:www.google.cn:check_ping$,$SERVICESTATEID:www.taobao.com:check_ping$,$SERVICESTATEID:www.sina.com.cn:check_ping$,$SERVICESTATEID:www.qq.com:check_ping$,$SERVICESTATEID:www.baidu.com:check_ping$
	use			cluster-service
	host_name		localhost
	event_handler   	check-host-alive
}

