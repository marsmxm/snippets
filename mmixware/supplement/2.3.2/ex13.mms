%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.3.2/ex13.mms
%	Author:	M.Ruckert
%	Title:	Exercise 13, Copy a binary tree using Algorithm C of 2.3.1

	PREFIX	:Copy:

%%%
p	IS	$0
rJ	IS	$1
u	IS	$2
q	IS	$3
r	IS	$4
t	IS	$5
%%%on
:Copy	BZ	p,9F		 1\bg{0}	&\ut C1. Initialize.\\
	GET	rJ,:rJ		 1 		&
	PUSHJ	u,:Allocate	 1 		&Create \.NODE(U). with $\.RLINK(U).=\Lambda$.
	SET	q,u		 1 		&$\.Q.\is\.U.$.
	JMP	C3		 1 		&To C3, the first time.
%%%
4H	PUSHJ	r,:Allocate	a		&$\.R.\Leftarrow \.AVAIL.$.
	STOU	r,q,:LLINK	a  		&$\.LLINK(Q).\is \.R.$.
	OR	t,q,1		a  		&
	STOU	t,r,:RLINK	a  		&$\.RLINK(R).\is \.Q.$, $\.RTAG(R).\is 1$.
	SET	q,r		a  		&\ut C5a. Advance.\\ $\.Q.\is \.LLINK(Q).$.
	LDOU	p,p,:LLINK	a		&$\.P.\is \.LLINK(P).$.
%%%
C2	LDOU	t,p,:RLINK	n-1		&\ut C2. Anything to right?\\
	BOD	t,C3		n-1\bg{a}		&Jump if  $\.RTAG(P).= 1$.
	PUSHJ	r,:Allocate	n-1-a  		&$\.R.\Leftarrow \.AVAIL.$.
	LDOU	t,q,:RLINK	n-1-a  		&
	STOU	t,r,:RLINK	n-1-a  		&$\.RLINK(R).\is \.RLINK(Q).$.
	STOU	r,q,:RLINK	n-1-a  		&$\.RLINK(Q).\is \.R.$, $\.RTAG(Q).\is 0$.
%%%
C3	LDOU	t,p,:INFO	 n		&\ut C3. Copy \.INFO..\\
	STOU	t,q,:INFO	 n 		&
%%%
	LDOU	t,p,:LLINK	 n		&\ut C4. Anything to left?\\
	BNZ	t,4B		 n\bg{a} 	&Jump if $\.LLINK(P).\ne\Lambda$.
%%%
C5B	LDOU	p,p,:RLINK	 n		&\ut C5b. Advance.\\ $\.P.\is \.RLINK(P).$.
	LDOU	q,q,:RLINK	 n 		&$\.Q.\is \.RLINK(Q).$.
%%%
	BOD	q,C5B		n\bg{a}	&Jump if $\.RTAG(Q).=1$.
%%%
	PBNZ	q,C2		 n-a \bg{1}	&\ut C6. Test if complete.\\ 	 
%%%
	STOU	u,u,:RLINK	 1		&$\.RLINK(U).\is \.U.$. 
	PUT	:rJ,rJ		 1 		&
	SET	$0,u		 1 		&Return \.U..
9H	POP	1,0				&\slug
%%%rt 2.3.2ex13.rt & (14n+7a+4)\upsilon + (9n-3)\mu
%%%off
	PREFIX	: