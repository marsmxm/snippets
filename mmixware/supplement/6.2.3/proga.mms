%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	6.2.3/proga.mms
%	Author:	M.Ruckert
%	Title:	Program A, Balanced tree search and insertion
	PREFIX	:btree:

head	IS	$0
k	IS	$1

t	IS	$3
p	IS	$4


a	IS	$5
c	IS	$6
la	IS	$7	 Offset of \.LINK($a$,P).
r	IS	$8	 
bp	IS	$9	 $c \mod 4$
q	IS	$10	 
kp	IS	$11	 
lm	IS	$12	 Offset of \.LINK($-a$,P).
x	IS	$13	 
ll	IS	$14	 
s	IS	$15	 

RLINK	IS	0
LLINK	IS	8
KEY	IS	16

%%%on
:Search	SET	t,head		1 & \ut  A1. Initialize.\\ $\.T.\is\.HEAD.$.\lineref|6.2.3progasearchstart|
	STO	k,t,KEY		1 & (See line |6.2.3progatsstart|.)
	LDOU	p,t,RLINK	1 & $\.P.\is \.RLINK(HEAD).$.
%%%off
	BZ	p,Empty		1\bg{0} &
%%%on
	JMP	A2		1 &\lineref|6.2.3progasearch|
%%%
0H	CSOD	t,q,p		C-1 & If $\.B(Q).\ne 0$, $\.T.\is \.LOC(LINK($a$,P)).$.^{CSOD+<CSOD> (conditional set if odd)}\lineref|6.2.3progamainstart|
	SET	p,q		C-1 & $\.P.\is \.Q.$.
%%\noalign{\sourcenext}
A2	LDO	kp,p,KEY	C & \ut  A2. Compare.\\ $\.kp. \is \.KEY(P).$.
	CMP	a,k,kp		C &  Compare $K$ and  $\.KEY(P).$; set $a$.
	BZ	a,Success	C\bg{S} & Exit if $K=\.KEY(P).$.
	ZSN	la,a,LLINK	C-S & $\.la.\is \.LINK($a$).$.
	LDOU	q,p,la		C-S & \ut  A3/4. Move left/right.\\ 
	PBNZ	q,0B		C-S\bg{1-S} &Jump if $\.Q.=\.LINK($a$,P).\ne\Lambda$. \lineref|6.2.3progasearchend|\lineref|6.2.3progamainend|
%%%
	LDOU	x,t,KEY		1-S & $\.x.\is \.KEY(T).$.\lineref|6.2.3progatsstart|
	CMP	a,k,x		1-S & Compare $K$ and  $\.KEY(T).$; set $a$.
	ZSN	x,a,LLINK	1-S &$\.x.\is \.LINK($a$).$.
	ADDU	t,t,x		1-S &$\.T.\is \.LOC(LINK($a$,T)).$.
	LDOU	s,t		1-S &$\.S.\is \.LINK($a$,T).$.\lineref|6.2.3progatsend|
%%%
	SET	q,:avail	1-S & \ut  A5. Insert.\\ $\.B(Q).\is 0$.\lineref|6.2.3progainsertstart| 
	BZ	q,:Overflow	1-S & 
	LDOU	:avail,:avail	1-S & $\.Q.\Leftarrow\.AVAIL.$.	
	STOU	q,p,la		1-S & $\.LINK($a$,P).\is \.Q.$.
	STCO	0,q,RLINK	1-S & $\.RLINK(Q).\is \Lambda$.
	STCO	0,q,LLINK	1-S & $\.LLINK(Q).\is \Lambda$.
	STO	k,q,KEY		1-S & $\.KEY(Q).\is K$.
%%%	
	LDO	kp,s,KEY	1-S &  \ut  A6. Adjust balance factors.\\ 
	CMP	a,k,kp		1-S & Compare $K$ and  $\.KEY(S).$; set $a$.
	ZSN	la,a,LLINK	1-S & $\.la.\is \.LINK($a$).$.\lineref|6.2.3progazsn|
	ADDU	ll,s,la		1-S & $\.ll.\is\.LOC(LINK($a$,S)).$.
	LDOU	p,ll		1-S & $\.P.\is \.LINK($a$,S).$.
	JMP	0F		1-S &
%%%
1H	LDO	kp,p,KEY	F &\kern 3em  $\.kp. \is \.KEY(P).$.
	CMP	c,k,kp		F &\kern 3em  $c \is K :  \.KEY(P).$.
	AND	x,c,3		F &\kern 3em   $\.x.\is c \mod 4$.
	OR	p,p,x		F &\kern 3em  $\.B(P).\is  K :  \.KEY(P).$.
	STOU	p,ll		F &\kern 3em  $\.LINK($c$,P).\is \.P.$.
	ZSN	x,c,LLINK	F &\kern 3em  $\.x.\is \.LINK($c$).$.
	ADDU	ll,p,x		F &\kern 3em  $\.ll.\is\.LOC(LINK($c$,P)).$.
	LDOU	p,ll		F &\kern 3em  $\.P.\is \.LINK($c$,P).$.
%%%
0H	CMPU	x,p,q		F+1-S &\kern 3em  $\.P.=\.Q.$?
	PBNZ	x,1B		F+1-S\bg{1-S}\kern -2em &\kern 3em Repeat until $\.P.= \.Q.$.\lineref|6.2.3progainsertend|
%%%     
	AND	a,a,3		1-S &\kern 3em   \ut  A7. Balancing act.\\\lineref|6.2.3progabalancestart|
	AND	x,s,3		1-S &\kern 3em    $\.x.\is\.B(S).$.
	BZ	x,i		1-S\bg{J} &\kern 3em   If $\.B(S).=0$, go to case (i).
	CMP	x,x,a		1-S-J &\kern 3em   $\.B(S).= a$?
	BZ	x,iii		1-S-J\bg{G+H}\kern -2em &\kern 3em If $\.B(S).=a$, go to case (iii).
%%%
ii	ANDN	s,s,3		1-S-J-G-H\kern -2em &\kern 3em (ii) 
	STOU	s,t		1-S-J-G-H\kern -2em &\kern 3em $\.B(S).\is 0$.
	POP	0,0
%%%			
i	LDO	x,head,LLINK	J & (i)
	ADD	x,x,1		J & The tree has grown higher.
	STO	x,head,LLINK	J & $\.LLINK(HEAD).\is\.LLINK(HEAD).+1$. 
	OR	s,s,a		J &
	STOU	s,t		J &  $\.B(S).\is a$.
	POP	0,0
%%%
iii	LDOU	r,s,la		G+H & (iii) $\.R.\is \.LINK(a,S).$.
	NEG	lm,LLINK,la	G+H & $\.lm.\is\.LINK($-a$).$.
	AND	x,r,3		G+H &  $\.x.\is \.B(R).$.
	CMP	x,a,x		G+H & $a = \.B(R).$?
	BZ	x,A8		G+H\bg{G} & Go to A8 if $\.B(R).=0$.
%%%
	LDOU	p,r,lm		H & \ut  A9. Double Rotation.\\
%%%
	LDOU	x,p,la		H &  $\.x.\is\.LINK($a$,P).$.
	STOU	x,r,lm		H & $\.LINK($-a$,R).\is \.LINK($a$,P).$.
%%%				B(S)=-B(S)=-a if B(P)=a else 0.
        AND	bp,p,3		H & $\.bp.\is \.B(P).$.
	CMP	x,bp,a		H & $\.B(P).= a$?
	CSZ	a,x,#02		H & $a\is -1\mod 4$, if $\.B(P).= a$.		
	XOR	s,s,a		H & $\.B(S).\is  \.B(P).= a \mathop{?} -\.B(S). : 0$.
%%%				B(R)=-B(R)=a if B(P)=-a else 0.
	CSZ	x,bp,0		H & $\.x.\is 0$, if $\.B(P).= a$.
	AND	bp,r,3		H & $\.bp.\is \.B(R).$.
	CSNZ	bp,x,#02	H & $\.bp.\is -1$, if $\.B(P).= -a$.
	XOR	r,r,bp		H & $\.B(R).\is \.B(P).= -a  \mathop{?} -\.B(R).:0$.
%%%
	STOU	r,p,la		H & $\.LINK($a$,P).\is \.R.$.
	LDOU	x,p,lm		H & $\.x.\is \.LINK($-a$,P).$. 
	STOU	x,s,la		H & $\.LINK($a$,S).\is \.LINK($-a$,P).$.
	STOU	s,p,lm		H & $\.LINK($-a$,P).\is \.S.$.
	ANDN	p,p,3		H & $\.B(P). = 0$?
%%%
	STOU	p,t		H &  \ut  A10. Finishing touch.\\ 
	POP	0,0
%%%
A8	ANDN	r,r,3		G & \ut  A8. Single Rotation.\\ $\.B(R).\is 0$.
	ANDN	s,s,3		G & $\.B(S).\is 0$.
	SET	p,r		G & $\.P.\is \.R.$.
	LDOU	x,r,lm		G & $\.x.\is \.LINK($-a$,R).$.
	STOU	x,s,la		G & $\.LINK($a$,S).\is \.LINK($-a$,R).$.
	STOU	s,r,lm		G & $\.LINK($-a$,R).\is \.S.$.
%%%
	STOU	p,t		G &  \ut  A10. Finishing touch.\\ 
	POP	0,0			&\lineref|6.2.3progabalanceend|
%%%
Success	SET	$0,p		S &
	POP	1,0		  &\slug
%%%off
Empty	SET	q,:avail	
	BZ	q,:Overflow	
	LDOU	:avail,:avail
	STOU	q,head,RLINK	
	STCO	1,head,LLINK
	STCO	0,q,RLINK
	STCO	0,q,LLINK
	STO	k,q,KEY
	POP	0,0
%%%
	PREFIX	: