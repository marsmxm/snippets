%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	6.2.2/progt.mms
%	Author:	M.Ruckert
%	Title:	Program T, Tree search and insertion
	PREFIX	:btree:

p	IS	$0	
k	IS	$1	


l	IS	$2	$x \is \.LLINK.$ if $k<k^\prime$, else $l_k\is \.RLINK.$.
q	IS	$3	
kp	IS	$4	
t	IS	$5	

RLINK	IS	0
LLINK	IS	8
KEY	IS	16

%%%on
0H	SET	p,q		C-1 & $\.P.\is \.Q.$.\lineref|6.2.2progteliminate|
%%%
:Search	LDO	kp,p,KEY	C & \ut  T2. Compare.\\ $\.kp. \is \.KEY(P).$.
	CMP	t,k,kp		C & 
	BZ	t,Success	C\bg{S} & Exit if $K=\.KEY(P).$.
	ZSN	l,t,LLINK	C-S & $\.l.\is (K<\.KEY(P).)\mathop{?} \.LLINK. : \.RLINK.$.
T3	LDOU	q,p,l		C-S & \ut  T3/4. Move left/right.\\ 
	PBNZ	q,0B		C-S\bg{1-S} &To T2 if $\.Q.\ne\Lambda$.\lineref|6.2.2-tsearchend|
%%%rt 6.2.2progt.search.rt    & (7C-3S+1)\upsilon+(2C-S)\mu
%%%
	SET	q,:avail		1-S &  \ut  T5. Insert.\\ 
	BZ	q,:Overflow		1-S & 
	LDOU	:avail,:avail,0		1-S & $\.Q.\Leftarrow\.AVAIL.$.	
	
	STOU	q,p,l		1-S & $\.LINK(P).\is \.Q.$.
	STCO	0,q,RLINK	1-S & $\.RLINK(Q).\is \Lambda$.
	STCO	0,q,LLINK	1-S & $\.LLINK(Q).\is \Lambda$.
	STO	k,q,KEY		1-S & $\.KEY(Q).\is K$.
%%%	
	POP	0,0		    & Exit after insertion.
%%%
Success	POP	1,0		    & Return node address.\quad\slug
%%%off
	PREFIX	: