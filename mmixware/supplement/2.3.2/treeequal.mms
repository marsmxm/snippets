	PREFIX	:Eq:
RIGHT	IS 0
LEFT    IS 8
INFO	IS 16

p	IS	$0
q	IS	$1
iq	IS	$2
ip	IS	$3
ret	IS	$4
t	IS	$5
	
:TreeEqual	BZ	p,1F

		LDO	iq,q,INFO
		LDO	ip,p,INFO
		CMP	t,iq,ip
		BNZ	t,:Fail
		GET	ret,:rJ
		LDOU	t+1,q,LEFT
		BOD	t+1,:Fail
		LDOU	t+2,p,LEFT
		BOD	t+2,:Fail
		PUSHJ	t,:TreeEqual
		LDOU	t,q,RIGHT
		XOR	t,t,q
		BZ	t,2F
		XOR	q,t,q
		LDOU	p,p,RIGHT
		XOR	t,p,q
		AND	t,t,1
		BNZ	t,:Fail
		BEV	p,:TreeEqual
		PUT	:rJ,ret
		POP	0,0		

2H		PUT	:rJ,ret
		LDOU	t,p,RIGHT
		XOR	q,t,p
1H		BNZ	q,:Fail
%%%
		POP	0,0

