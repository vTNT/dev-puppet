ssh_authorized_key {"user":
  ensure  => present,
  type    => "ssh-dss",
  key     => "xxx",
  user    => "sky",
}
