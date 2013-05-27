class cron {
        case $operatingsystem {
                centos:{
                        include cron::base
                        include cron::crontabs
                        include cron::addcron
                }
         }
}
