class logrotate::web inherits logrotate {

     #make sure the backup dir is existed
        file {"$backup_nginx":
          ensure  => present,
        }
     #create the logrotate nginx file and scripts
        file {"logrotate_nginx_conf":
          owner   => root,
          group   => root,
          mode    => 644,
          path    => "$logrotate_scripts_dir/logrotate_nginx.conf",
          content => template('logrotate/logrotate_nginx_conf.erb'),
        }
        file {"logrotate_nginx_sh":
          owner   => root,
          group   => root,
          mode    => 644,
          path    => "$logrotate_scripts_dir/logrotate_nginx.sh",
          content => template('logrotate/logrotate_nginx_sh.erb'),
        }
     #crontab logrotate nginx log
        cron {"logrotate nginx log":
          command => "bash $logrotate_scripts_dir/logrotate_nginx.sh",
          user    => root,
          minute  => 59,
          hour    => 23,
          require => File['logrotate_nginx_conf','logrotate_nginx_sh'],
        }

     #make sure the backup dir is existed
        file {"$backup_php":
          ensure  => present,
        }
     #create the logrotate php file and scripts
        file {"logrotate_php_conf":
          owner   => root,
          group   => root,
          mode    => 644,
          path    => "$logrotate_scripts_dir/logrotate_php.conf",
          content => template('logrotate/logrotate_php_conf.erb'),
        }
        file {"logrotate_php_sh":
          owner   => root,
          group   => root,
          mode    => 644,
          path    => "$logrotate_scripts_dir/logrotate_php.sh",
          content => template('logrotate/logrotate_php_sh.erb'),
        }
        cron {"logrotate php log":
          command   => "bash $logrotate_scripts_dir/logrotate_php.sh",
          user      => root,
          minute    => 59,
          hour      => 23,
          require   => File['logrotate_php_conf','logrotate_php_sh'],
        }
}
