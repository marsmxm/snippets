%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	6.3/progd.mms
%	Author:	M.Ruckert
%	Title:	Exercise 9, Algorithm D
%       programed similar to 6.2.2/progt.mms
	PREFIX	:btree:

p	IS	$0	
k	IS	$1	

l	IS	$2	\.LLINK. if $k<k^\prime$, else \.RLINK..
kp	IS	$3
q	IS	$5
s	IS	$6
t	IS	$7


RLINK	IS	0
LLINK	IS	8
KEY	IS	16

%%%on
:Search	SET	s,k		1 & \ut  D1. Initialize.\\ $K^\prime \is K$.
	JMP	D2		1 &
0H	SET	p,q		C-1 & $\.P.\is \.Q.$.
	SLU	s,s,1		C-1 & 
%%%
D2	LDO	kp,p,KEY	C & \ut  D2. Compare.\\ $\.kp. \is \.KEY(P).$.
	CMP	t,k,kp		C & 
	BZ	t,Success	C\bg{S} & Exit if  $K=\.KEY(P).$. 
	ZSNN	l,s,LLINK	C-S & $\.l.\is b\mathop{?} \.LLINK. : \.RLINK.$.
	LDOU	q,p,l		C-S & \ut  D3/4. Move left/right.\\ $\.Q.\is \.LINK($b$,P).$. 
	PBNZ	q,0B		C-S\bg{1-S} &
%%%
%%%rt 6.3progd.rt & (8C-3S+2)\upsilon+(2C-S)\mu
	%\hbox{\rm $\langle$Continue as in Program 6.2.2T.$\rangle$}\quad\slug
%%%
%%%off
	SET	q,:avail		1-S &  \ut  T5. Insert.\\ 
	BZ	q,:Overflow		1-S & 
	LDOU	:avail,:avail,0		1-S & $\.Q.\Leftarrow\.AVAIL.$.	
	
	STOU	q,p,l		1-S & $\.LINK(P).\is \.Q.$.
	STCO	0,q,RLINK	1-S & $\.RLINK(Q).\is \Lambda$.
	STCO	0,q,LLINK	1-S & $\.LLINK(Q).\is \Lambda$.
	STO	k,q,KEY		1-S & $\.KEY(Q).\is K$.
%%%	
	POP	0,0
%%%
Success	POP	1,0
%%%off
	PREFIX	: