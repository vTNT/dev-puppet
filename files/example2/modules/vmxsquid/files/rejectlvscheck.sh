#!/bin/bash
iptables -A INPUT -s 10.0.0.0/8 -p tcp --dport 80 -j DROP
iptables -A INPUT -s 10.0.0.0/8 -p tcp --dport 81 -j DROP
iptables -A INPUT -s 10.0.0.0/8 -p tcp --dport 3128 -j DROP
iptables -A INPUT -s 10.0.0.0/8 -p tcp --dport 8080 -j DROP
