#!/bin/bash
idobl="/etc/squid/ido_bl"
vmxbl="/etc/squid/vmx_bl"
idobl2="/etc/squid/ido_bl.back"
vmxbl2="/etc/squid/vmx_bl.back"
idobl_url="ftp://10.101.8.172:21/idobl/ido_bl"
vmxbl_url="ftp://10.0.7.2/vmxbl/vmx_bl"
cp $idobl $idobl2
cp $vmxbl $vmxbl2
curl -s -q -w "" $idobl_url >$idobl
curl -s -q -w "" $vmxbl_url >$vmxbl
