########################   for module rsync ######################
$rsync_server       = "xxx.xxx.xxx.xxx"
$rsync_dir          = ["/data","/data/backup","/data/backup/log"]    #salt cmd.run 'mkdir'
$rsync_password     = "rsync"
$rsync_user         = "rsync"
$rsync_scripts_dir  = "/home/cron"          #salt cmd.run 'mkdir'

########################   for modele logrotate ##################
$backup_nginx           = ["/data","/data/backup","/data/backup/log","/data/backup/log/nginx"]  #salt cmd.run 'mkdir'
$nginx_log              = "/data/log/nginx"
$nginx_pid              = "/usr/local/nginx/nginx.pid"

$backup_php             = ["/data","/data/backup","/data/backup/log","/data/backup/log/php"]     #salt cmd.run 'mkdir'
$php_log                = "/usr/local/php/var/log"
$php_pid                = "/usr/local/php/var/run/php-fpm.pid"

$backup_mysql           = ["/data","/data/backup","/data/backup/log","/data/backup/log/mysql"]    #salt cmd.run 'mkdir'
$mysql_slow_log         = "/var/log/mysql"
$flush_user             = "xxx"
$flush_password         = "xxxx"                      #亲自去db端创建mysql刷新用户和密码

$logrotate_scripts_dir  = ["/home/cron","/home/cron/logrotate"]      #salt cmd.run 'mkdir'

########################   for module cacti  ########################
$monitor_ip         = "xxx.xxx.xxx.xxx"
$snmp_passwd        = "xxx"

########################   for module salt   ########################
$server_ip          = "xxx.xxx.xxx.xxx"

########################   for module nagios ########################
$nagios_server      = "xxx.xxx.xxx.xxx"

###################################################################
import "modules.pp"
import "nodes/*.pp"
import "utils.pp"
#import "nagios.pp"
  $interface = { 
          name    => 'eth0',
          address => '192.168.10.1'
  }

##################################
node 'rpm.salt.com' {
    include nagios::web
    include user
    #@user {"xx":
    #  ensure  => present,
    #  tag     => ['abc','a'],
    #  groups   => wheel,
    #}
    #@user {"c":
    #  ensure  => present,
    #  tag     => ['abc'],
    #}
    #realize user['xx'],user['c']
    realize user['c']
    user::deluser {"userdel kk":
            username  => kk,
    }

    User <| groups == wheel |>
    #include firewall
    #  firewall {"xxx":
    #    open_tcp  => ["80","443"]
    #  }
    #include sudo
    #include sudo
    #sudo::sudoers { "users":
    #    sudo_sysadmins => ['xuf','linyd'],
    #    sudo_sudoers   => ['zougc','wangyw']
    #}
    #include user
    #user::adduser {"xxx":
    #  username => aaa,
    #  group  => devvv,
    #  password => xxx,
    #}
    #class { 'sudobak':
    #  sudo_sysadmins  => 'aa,bb',
    #  sudo_sudoers    => 'cc,dd',
    #}
}
##################################
node /^redis\.\w+\.com$/ {
#@@file { "/tmp/file11":
#  content => "xxx",
#  tag     => "bb",
#}
#    #file { "/tmp/aa" :
          #content => "a",
          #backup  => ".bak",
    #}
  #cron { "run-puppet":
  #  command =>  "/usr/sbin/puppet agent --test > /dev/null 2>&1",
  #  minute  =>  inline_template("<%= hostname.hash.abs % 60 %>"),
  #}

  #augeas { "sshd_config":
  #  context => "/files/etc/ssh/sshd_config",
  #  changes => [
  #    "set PermitRootLogin no",
  #    ],
  #}  
  # nagios_web { "xm-manage-web":
  #    webhost => "xm-manage-web",
  #    webip   => "192.168.20.12",
  # }
  # nagios_web { "xm-trans-web":
  #    webhost => "xm-trans-web",
  #    webip   => "192.168.20.13",
  # }
  #include cacti::db
  #include rsync::addcrons
  #include salt::client
  include nagios::web
}

