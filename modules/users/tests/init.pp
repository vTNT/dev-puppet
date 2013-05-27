include sudo
sudo::sudoers { "example":
  sudo_sysadmins => ['test-wheel-1','test-wheel-2'],
  sudo_sudoers   => ['test-sudo-1'],
}
