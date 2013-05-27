class logrotatebase {
        package {"logrotate":
          ensure  => present,
        }

        file {"$logrotate_scripts_dir":
          ensure  => present,
        }
}
