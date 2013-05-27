class admin::ipforward {
        augeas {"enable-ip-forwarding":
          context => "/files/etc/sysctl.conf",
          changes => [
            "set net.ipv4.ip_forward 1",
            "set xxxx.xxxx_xxxxxxxxx 0"],
        }
}
