node 'slave.puppet.com' {
        include "cron"
        include "cactiweb"
        include "logrotatelnmp"
        #include "rsync"
        
}
