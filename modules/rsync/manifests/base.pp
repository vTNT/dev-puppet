class rsync::base {
        package {"rsync":
          ensure  => present,
        }

        file {"$rsync_scripts_dir":
          ensure  => directory,
        }

}
