class salt {
        case $operatingsystem {
                centos:{
                        include salt::base
                        include salt::service
                }
        }
}
