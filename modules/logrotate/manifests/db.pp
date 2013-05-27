class logrotate::db inherits logrotate {

     #make sure the backup dir is existed
        file {"$backup_mysql":
          ensure  => present,
        }
     #create the logrotate mysql file and scripts
        file {"logrotate_mysql_conf":
          owner   => root,
          group   => root,
          mode    => 644,
          path    => "$logrotate_scripts_dir/logrotate_mysql.conf",
          content => template('logrotate/logrotate_mysql_conf.erb'),
        }
        file {"logrotate_mysql_sh":
          owner   => root,
          group   => root,
          mode    => 644,
          path    => "$logrotate_scripts_dir/logrotate_mysql.sh",
          content => template('logrotate/logrotate_mysql_sh.erb'),
        }
     #crontab logrotate mysql slow log
        cron {"logrotate mysql slow log":
          command => "bash $logrotate_scripts_dir/logrotate_mysql.sh",
          user    => root,
          minute  => 59,
          hour    => 23,
          require => File['logrotate_mysql_conf','logrotate_mysql_sh'],
        }
}
