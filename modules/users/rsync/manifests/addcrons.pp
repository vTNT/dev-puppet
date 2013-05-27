class rsync::addcrons inherits rsync::base {
        file{"rsync.sh":
          owner   => root,
          group   => root,
          mode    => 644,
          path    => "$rsync_scripts_dir/rsync.sh",
          content => template('rsync/rsync_sh.erb'),
        }

        file{"rsync.password":
          owner   => root,
          group   => root,
          mode    => 600,
          path    => "$rsync_scripts_dir/rsync.password",
          content => template('rsync/rsync_password.erb'),
          require => File["rsync.sh"]
        }

        cron {"rsync log":
          command => "bash $rsync_scripts_dir/rsync.sh $rsync_dir $rsync_user@${rsync_server}::log/$fqdn/",
          user    => root,
          minute  => 00,
          hour    => 02
        }
}

