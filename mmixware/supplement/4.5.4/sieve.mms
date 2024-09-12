%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.5.4/sieve.mms
%	Author:	M.Ruckert
%	Title: Program D improved with sieves

	PREFIX :Factor:
N	IS	$0
x	IS	$1
y	IS	$2
r	IS	$3
sieve	IS	$4
k1	IS	$5
k2	IS	$6
k3	IS	$7
kr	IS	$8
b	IS	$9
xb	IS	$10
t	IS	$11

m1	IS 3
m2	IS 5
m3	IS 7
mr	IS 11

S1	GREG	@
	OCTA	0,0,0      m1=3
S2	GREG	@
	OCTA	0,0,0,0,0      m2=5
S3	GREG	@
     	OCTA    0,0,0,0,0,0,0      m3=7
Sr	GREG	@
        OCTA	0,0,0,0,0,0,0,0,0,0,0      mr=11


%%%
:Factor	FLOT	x,:ROUND_UP,N
	FSQRT	x,:ROUND_UP,x	  
	FIXU	x,:ROUND_UP,x      $x\is \lceil\sqrt{N}\rceil$.
	SET	k1,(m1-1)*8
	SET	k2,(m2-1)*8
	SET	k3,(m3-1)*8
	SET	kr,(mr-1)*8
%%%on
D2	LDOU	sieve,S1,k1			$\.sieve.\is S^\prime[1,k^\prime_1]$.
	CSZ	k1,k1,m1*8; SUB	k1,k1,8		$k_1\is(k_1-64)\mod \lcm(m_1,64)$.
	LDOU    t,S2,k2; AND sieve,sieve,t	&$\.sieve.\is \.sieve. \band S^\prime[2,k^\prime_2]$.
	CSZ	k2,k2,m2*8; SUB	k2,k2,8		$k_2\is(k_2-64)\mod \lcm(m_2,64)$.
%%%\mmsskip 
% 	&\mmsvdots&&&($m_3$ through $m_r$ are like $m_2$)
%%%\mmsskip 
%%%off
	LDOU 	t,S3,k3; AND sieve,sieve,t	&$\.sieve.\is \.sieve.\band S^\prime[3,k^\prime_3]$.
	CSZ	k3,k3,m3*8; SUB	k3,k3,8		$k_3\is(k_3-64)\mod \lcm(m_3,64)$.
%%%on
	LDOU 	t,Sr,kr; AND sieve,sieve,t	&$\.sieve.\is \.sieve.\band S^\prime[r,k^\prime_r]$.
	CSZ	kr,kr,mr*8; SUB	kr,kr,8		$k_r\is(k_r-64)\mod \lcm(m_r,64)$.
	ADD	x,x,64	    			$x\is x+64$.
	PBZ	sieve,D2			Repeat if all sieved out.\quad\slug
%%%off
%	Iterate over the bits in sieve
D4	SUBU	t,sieve,1
	SADD	t,t,sieve		^{SADD+<SADD> (sideways add)}^{Sideways addition}
	SUB	xb,x,64			Undo addition.
	ADD	xb,xb,t
	SET	b,1
	SL	b,b,t
	ANDN	sieve,sieve,b			remove bit from \.sieve.
	MULU	r,xb,xb
	SUBU	r,r,N			$r\s x^2-N$.
	FLOT	y,:ROUND_UP,r
	FSQRT	y,:ROUND_UP,y
	FIXU	y,:ROUND_UP,y      $y\is \lceil\sqrt{x^2-N}\rceil$.
	MULU	t,y,y
	CMPU	t,t,r
	BZ	t,1F
	SUB	y,y,1
	MULU	t,y,y
	CMPU	t,t,r	
	BZ	t,1F
	BNZ	sieve,D4
	JMP	D2
%%%
1H	SUB	$0,xb,y
	POP	1,0
%%%off


		PREFIX	:MkTable:
		%	Assuming that m is not even, lcm(m,64) = m.
		%	Hence w have to fill m OCTAS with a repeating
		%	pattern of m bit.
		% 	We determine the pattern first, then we fill.
		%	We assume m<64 so an octa will suffice for the pattern. 

N		IS	$0
m		IS	$1
S		IS	$2	Address for Table.

x		IS	$3
r		IS	$4
q		IS	$5
s		IS	$6
i		IS	$7
k		IS	$8
p		IS	$9	the pattern
n		IS	$10	N mod m
t		IS	$11

MkTable		FLOT	x,:ROUND_UP,N
		FSQRT	x,:ROUND_UP,x
		FIXU	x,:ROUND_UP,x      $x\is \lceil\sqrt{N}\rceil$.
%%%
		DIV	t,x,m; GET k,:rR
		SUB 	t,m,k; CSNZ k,k,t    $k\is (-x)\mod m$.
		SET	p,0		Initialize p to zero.
		SET	x,m
0H		SUB	x,x,1		Make table of $x^2\mod m$.
		MUL	r,x,x
		DIV	r,r,m
		GET	r,:rR
		STB	r,:Q,x
		BP	x,0B
%%%
		DIV	t,N,m; GET n,:rR	$n\is N\mod m$.
%%%
		SET	x,m					
0H		SUB	x,x,1
		LDB	q,:Q,x		$q\is (x^2)\mod m$.
		SUB	q,q,n; ZSN t,q,m; ADD q,q,t 	$q\is (x^2-N)\mod m$.
%%%		find q in Q
		SET     i,m
1H		SUB	i,i,1
		LDB	t,:Q,i
		CMP	t,t,q
		BNZ	t,2F
		SETH	t,#8000; SRU t,t,x
		OR	p,p,t		Set bit in p
		JMP	3F
2H		BP	i,1B
%%%
3H		BP	x,0B		Loop on $x$.
%%%		Filling the Table
		SL	i,m,3		 Number of octabyte to fill
		SL	n,m,6 
%%%
		SUB 	n,n,k		Top bit to fill
		SUB	n,n,1
%%%		
0H		SUB	i,i,8		 Octabyte to place the first pattern
		SET	s,0		 Table zero
		AND	x,n,#3F		n mod 64 offset in octabyte
%%%
1H		SRU	t,p,x		position pattern
		OR	s,s,t		add pattern
		SUB	n,n,m		advance n
		SUB	x,x,m		advance x
		BNN	x,1B		repeat while offset nonnegative
%%%
		NEG	x,x		x might be negative
		SLU	t,p,x		position last pattern
		OR	s,s,t		add pattern
		STOU	s,S,i		store table
		BP	i,0B		repeat for all octabytes
		POP	0,0


rJ		IS	$1
:MkTables	GET	rJ,:rJ
		SET	t+1,N
		SET	t+2,:Factor:m1	
		SET	t+3,:Factor:S1
		PUSHJ	t,MkTable
%%%
		SET	t+1,N
		SET	t+2,:Factor:m2	
		SET	t+3,:Factor:S2
		PUSHJ	t,MkTable
%%%
		SET	t+1,N
		SET	t+2,:Factor:m3	
		SET	t+3,:Factor:S3
		PUSHJ	t,MkTable
%%%
		SET	t+1,N
		SET	t+2,:Factor:mr	
		SET	t+3,:Factor:Sr
		PUSHJ	t,MkTable
%%%		
		PUT	:rJ,rJ
		POP	0,0