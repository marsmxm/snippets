%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	6.2.3/search.mms
%	Author:	M.Ruckert
%	Title:	Program A, Balanced tree search only
	PREFIX	:search:

p	IS	$0
k	IS	$1


a	IS	$2
la	IS	$3	 Offset of \.LINK($a$,P).
kp	IS	$4	 

RLINK	IS	0
LLINK	IS	8
KEY	IS	16

%%%rton
Search		LDOU	p,p,RLINK	1 & \ut  A1. Initialize.\\ $\.P.\is \.RLINK(HEAD).$.
%%%on
%%&:Search&	LDOU&	p,p,RLINK&	1 & \ut  A1. Initialize.\\ $\.P.\is \.RLINK(HEAD).$.\cr
%%%
	BZ	p,Failure	1\bg{0} &
%%%on
A2	LDO	kp,p,KEY	C & \ut  A2. Compare.\\ $\.kp. \is \.KEY(P).$.
	CMP	a,k,kp		C &  Compare $K$ and  $\.KEY(P).$; set $a$.
	BZ	a,Success	C\bg{S} & Exit if $K=\.KEY(P).$.
	ZSN	la,a,LLINK	C-S & $\.la.\is \.LINK($a$).$.
	LDOU	p,p,la		C-S & \ut  A3/4. Move left/right.\\ $P\is \.LINK($a$,P).$. 
%%%
	PBNZ	p,A2		C-S\bg{1-S}\hidewidth&
Failure	POP	0,0			& Not found.
%%%
Success	POP	1,0		  &\slug
%%%rt 6.2.3search.rt & (6C-3S+4)\upsilon + (2C-S+1)\mu
%%%off
	PREFIX	: