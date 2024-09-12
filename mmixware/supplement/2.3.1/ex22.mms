%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.3.1/ex22.mms
%	Author:	M. Ruckert 
%	Title:	Exercise 22
% Solution with R eliminated (as in Knuth's MIX solution)
%%% 
	PREFIX	:Inorder:

p       IS      $0
visit	IS	$1
rJ	IS	$2

q	IS	$3
rq	IS	$4
t	IS	$5
%%% 
RLINK   IS      0
LLINK   	IS      8
INFO    IS      16
%%%on
:Inorder	BZ	p,1F 	1\bg{0} &  \ut U2. Done?\\ Stop if $\.P.=\Lambda$.
	GET	rJ,:rJ	1 &
U3	LDOU	q,p,LLINK	n+a-1 &  \ut U3. Look left.\\ $\.Q.\is\.LLINK(P).$.
	PBZ	q,U6		n+a-1\bg{a-1}\hidewidth &  \qquad To U6 if $\.Q.=\Lambda$.
U4	LDOU	rq,q,RLINK	2c &  \ut U4. Search for thread.\\
	CMP	t,rq,p		2c &  
	BZ	t,5F		2c\bg{a-1} & Branch if $\.RLINK(Q).=\.P.$.
	CSNZ	q,rq,rq		d &  $\.Q.\is\.RLINK(Q).$ if $\.RLINK(Q).\ne \Lambda$.
	PBNZ	rq,U4		d\bg{a-1} & Continue with U4 if $\.RLINK(Q).\ne \Lambda$.
	STOU	p,q,RLINK	a-1 &  \ut  U5a. Insert thread.\\ $\.RLINK(Q).\is \.P.$.
	LDOU	p,p,LLINK	a-1 &  \ut  U9. Go to left.\\ $\.P.\is \.LLINK(P).$.
	JMP	U3		a-1 &  To U3.
5H	STCO	0,q,RLINK	a-1 &  \ut  U5b. Remove thread.\\  $\.RLINK(Q).=\Lambda$.
U6	SET	t+1,p		n & \ut  U6. Inorder visit \.P..\\
	PUSHGO	t,visit,0	n &^{PUSHGO+<PUSHGO> (push registers and go)}
	LDOU	p,p,RLINK	n &  \ut  U7. Go to right or up.\\ 
	PBNZ	p,U3		n\bg{1} &  \ut  U2. Done?\\ To U3 if $\.P.\ne \Lambda$.
	PUT	:rJ,rJ	1 &
1H	POP	0,0			&\slug	
%%%off
	PREFIX	: