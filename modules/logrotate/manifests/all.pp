class logrotatebase {
        package {"logrotate":
          ensure  => present
        }

        file {"$logrotate_scripts_dir":
          ensure  => present
        }
}
class logrotatenginx {
       include logrotatebase

     #make sure the backup dir is existed
        file {"$backup_nginx":
          ensure  => present
        }
     #create the logrotate nginx file and scripts
        file {"logrotate_nginx_conf":
          owner   => root,
          group   => root,
          mode    => 644,
          path    => "$logrotate_scripts_dir/logrotate_nginx.conf",
          content => template('logrotate/logrotate_nginx_conf.erb'),
          require => Class["logrotatebase"]
        }
        file {"logrotate_nginx_sh":
          owner   => root,
          group   => root,
          mode    => 644,
          path    => "$logrotate_scripts_dir/logrotate_nginx.sh",
          content => template('logrotate/logrotate_nginx_sh.erb'),
          require => Class["logrotatebase"]
        }
     #crontab logrotate nginx log
        cron {"logrotate nginx log":
          command => "bash $logrotate_scripts_dir/logrotate_nginx.sh",
          user    => root,
          minute  => 59,
          hour    => 23,
          require => File['logrotate_nginx_conf','logrotate_nginx_sh']
        }
}

class logrotatephp {
        include logrotatebase

     #make sure the backup dir is existed
        file {"$backup_php":
          ensure  => present
        }
     #create the logrotate php file and scripts
        file {"logrotate_php_conf":
          owner   => root,
          group   => root,
          mode    => 644,
          path    => "$logrotate_scripts_dir/logrotate_php.conf",
          content => template('logrotate/logrotate_php_conf.erb'),
          require => Class["logrotatebase"]
        }
        file {"logrotate_php_sh":
          owner   => root,
          group   => root,
          mode    => 644,
          path    => "$logrotate_scripts_dir/logrotate_php.sh",
          content => template('logrotate/logrotate_php_sh.erb'),
          require => Class["logrotatebase"]
        }
        cron {"logrotate php log":
          command => "bash $logrotate_scripts_dir/logrotate_php.sh",
          user    => root,
          minute  => 59,
          hour    => 23,
          require   => File['logrotate_php_conf','logrotate_php_sh']
        }
}

class logrotatemysql {
       include logrotatebase

     #make sure the backup dir is existed
        file {"$backup_mysql":
          ensure  => present
        }
     #create the logrotate mysql file and scripts
        file {"logrotate_mysql_conf":
          owner   => root,
          group   => root,
          mode    => 644,
          path    => "$logrotate_scripts_dir/logrotate_mysql.conf",
          content => template('logrotate/logrotate_mysql_conf.erb'),
          require => Class["logrotatebase"]
        }
        file {"logrotate_mysql_sh":
          owner   => root,
          group   => root,
          mode    => 644,
          path    => "$logrotate_scripts_dir/logrotate_mysql.sh",
          content => template('logrotate/logrotate_mysql_sh.erb'),
          require => Class["logrotatebase"]
        }
     #crontab logrotate mysql slow log
        cron {"logrotate mysql slow log":
          command => "bash $logrotate_scripts_dir/logrotate_mysql.sh",
          user    => root,
          minute  => 59,
          hour    => 23,
          require => File['logrotate_mysql_conf','logrotate_mysql_sh']
        }
}
#####################logrotate nginx + php ############################
class logrotateweb {
        include logrotatenginx
        include logrotatephp
}

####################logrotate nginx + mysql + php ####################
class logrotatelnmp {
        include logrotatenginx
        include logrotatephp
        include logrotatemysql
}

