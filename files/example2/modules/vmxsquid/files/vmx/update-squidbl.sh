#!/bin/bash
vmxbl="/etc/squid/vmx_bl"
vmxbl2="/etc/squid/vmx_bl.back"
vmxbl_url="ftp://10.0.7.2/vmxbl/vmx_bl"
cp $vmxbl $vmxbl2
curl -s -q -w "" $vmxbl_url >$vmxbl
