#
# site.pp - vmmatrix all server configure
# 

###########################[      resources  default setting   ]################################
Exec { path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" }
File { 
	ignore => '.svn',
	ensure => present,
	mode => 0644, owner => root, group => root,
}
Package { provider => "apt" }
Service { provider => "debian" }


###########################[      variable setting   ]################################
#  fileserver ??  ip ??
#
#
#
#########################################################################################
$fileserver = "sh-zj1.tele.trac.i.vmx.cn"
$svnserver = "10.0.7.2"
$puppetserver = "10.0.7.2"
$vmxpackageserver = "10.0.7.2"
$mirrorserver = "debian.cn99.com"
$timeserver = "222.73.106.220"
# mysql password #
$password = "vmmatrixsecpasswd2004"
$nscaservers = "10.0.8.130 10.0.66.130"

###########################[      modules variable setting,don't forget   ]##############
#
#$dirstruct
#
# when add a idc ,need change this variable for nagios2



## Main manifest ##
node default {
	include dbp
	include ssh
}


import "modules.pp"
import "roles.pp"
import "nodes/*.pp"
