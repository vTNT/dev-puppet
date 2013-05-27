# for user traffic 
node 'sh-zj4.tele.cacti.i.vmx.cn' {
	include dbp
	include centercacti
	}

node 'sh-nj1.cm.log.i.vmx.cn','sh-zj1.tele.log.i.vmx.cn','ln-sy4.cnc.db.i.vmx.cn','sz-lg1.tele.log.i.vmx.cn','memdb1.waigao.vmmatrix.net'{
	include dbp
	include apache2
	include cactiforclient
	}

