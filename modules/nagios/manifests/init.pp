class nagios {
        include "nagios::base,nagios::web,nagios::mysql"
}
import "nagios.pp"


