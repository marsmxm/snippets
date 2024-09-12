%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.5/ex16.mms
%	Author:	M. Ruckert
%	Title:	Exercise 16

%%%Algorithm 2.5-C Step C2 will not work if the
%%%NODE(AVAIL) immediately preceedes NODE(P0).
%%%Because the tetrabyte preceeding the used memory aerea must be markes.
%%%One could change the specification of AVAIL and mark it as used.
%%%TAG(AVAIL) is never tested directly in Algorithm 2.5-A or 2.5-C
%%%but it may be tested indirectly if the next node in memory is freed.

		PREFIX	:Free:

p0		IS	$0		Parameter
rlink		IS	$1
llink		IS	$2
size		IS	$3
psize		IS	$4
n		IS	$5
p1		IS	$6
f		IS	$7
b		IS	$8
n1		IS	$9
n2		IS	$10
t		IS	$11

SIZE		IS	0
RLINK		IS	4
LLINK		IS	8


%%%on
:Free		LDA	size,:AVAIL+SIZE	Base address for \.SIZE. field, 
		LDA	rlink,:AVAIL+RLINK	\qquad for \.RLINK. field,
		LDA	llink,:AVAIL+LLINK	\qquad for \.LLINK. field, and
		SUBU	psize,size,4	 	\qquad for preceding \.SIZE..
		SUBU	p0,p0,rlink		Make \.P0. a relative address.
		LDTU	n,size,p0		\ut  D1. Initialize.\\ $\.N.\is \.SIZE(P0).$.
		ANDN	n,n,1			Remove \.TAG. bit.	
		ADDU	p1,p0,n			$\.P1.\is \.P0.+\.N.$.
		LDTU	n1,size,p1		$\.N1. \is \.SIZE(P1).$.
		LDTU	n2,psize,p0		$\.N2. \is \.PSIZE(P0).$.
		BEV	n1,D4			To D4 if \.NODE(P1). is free.
		BEV	n2,D7			To D7 if \.NODE(P2). is free.
D3		LDTU	f,llink,0		\ut  D3. Insert \.P0..\\ $\.F.\is\.LLINK(AVAIL).$.
		SET	b,0			$\.B.\is\.AVAIL.$. 
		JMP	D5
D4		ADD	n,n,n1			\ut  D4. Delete upper area.\\ $\.N.\is \.N.+ \.SIZE(P1).$.
		LDTU	b,llink,p1		$\.B.\is \.LLINK(P1).$.
		LDTU	f,rlink,p1		$\.F.\is \.RLINK(P1).$.
		CMP	t,p1,:rover
		CSZ	:rover,t,0		If $\.P1. = \.ROVER.$, set $\.ROVER.\is \.AVAIL.$.
		ADDU	p1,p1,n1		$\.P1.\is \.P1.+ \.SIZE(P1).$.
		BEV	n2,D6			To D6 if  \.NODE(P2). is free.
D5		STTU	f,rlink,p0		\ut  D5. Insert \.NODE.(\.P0.).\\ $\.RLINK(P0).\is \.F.$.
		STTU	b,llink,p0		$\.LLINK(P0).\is \.B.$.
		STTU	p0,rlink,b		$\.RLINK(B).\is \.P0.$.
		STTU	p0,llink,f		$\.LLINK(F).\is \.P0.$.
		JMP	D8
D6		STTU	f,rlink,b		\ut  D6. Delete.\\ $\.RLINK(B).\is \.F.$.
		STTU	b,llink,f		$\.LLINK(F).\is \.B.$.
D7		ADD	n,n,n2			\ut  D7. Enlarge lower area.\\
		SUBU	p0,p0,n2		Move \.P0. to \.NODE(P2)..
D8		STTU	n,size,p0		\ut  D8. Store \.SIZE..\\ $\.SIZE(P0).\is \.N.$.
		STTU	n,psize,p1		$\.PSIZE(P1).\is \.N.$.
		POP	0,0			\slug
%%%off
		PREFIX	: