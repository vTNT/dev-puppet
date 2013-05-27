class rsync {
        case $operatingsystem {
                centos:{
                        include rsync::base
                        include rsync::addcrons
                }
        }
}
