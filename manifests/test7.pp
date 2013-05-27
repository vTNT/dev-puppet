$interface = { 
name    => 'eth0',
address => '192.168.10.1'
}
notice ("interface ${interface[name]} has address ${interface[address]}")
notice ("this is the real ip : ${::interfaces}")
notice ($virtual)



