class cron::addcron {
        cron {"ntpdate":
              command => "/usr/sbin/ntpdate xxx.xxx.xxx.xxx",
              user => root,
              hour => "*/1",
            }
}
