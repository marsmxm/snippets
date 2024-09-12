%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.5/ex13.mms
%	Author:	M. Ruckert
%	Title:	Exercise 13
%	Reserved block:	 TETRA	X,SIZE+1, ... ,SIZE+1,X
%	Free block:	 TETRA	X,SIZE,RLINK,LLINK, ... ,SIZE,X  
%	with Left, rlink, and size even. size = the complete size in byte.

		PREFIX	:Allocate:
%%%		assuming we are in some sort of data/pool segment
%%%	
n		IS	$0			Parameter: Number of bytes needed.
%%%
p 		IS	$1
f		IS	$2
size		IS	$3
rlink		IS	$4
llink		IS	$5
psize		IS	$6
k		IS	$7
l		IS	$8		Return value.
s		IS	$9
q		IS	$10
t		IS	$11
%%%
c		IS	32		Minimum 16 (two octabytes).

SIZE		IS	0
RLINK		IS	4
LLINK		IS	8

%%%on
:Allocate	ADD	n,n,8+7		 1 	&\ut  A.1 Initialize.\\ 
		ANDN	n,n,7		 	 1 	&Add overhead and round up.
		LDA	size,:AVAIL+SIZE	 1 	&Base address for \.SIZE. field, 
		LDA	rlink,:AVAIL+RLINK	 1 	&\qquad for \.RLINK. field,
		LDA	llink,:AVAIL+LLINK	 1 	&\qquad for \.LLINK. field, and
		SUBU	psize,size,4	 	 1 	&\qquad for preceding \.SIZE..
		SET	p,:rover			 1	&$\.P.\is\.ROVER.$.
		SET	f,0		 	 1	&$\.F.\is 0$.
		JMP	A2		 	 1 	&Start the search.
%%%
A3		LDTU	s,size,p		 A	&\ut  A3. Is \.SIZE. enough?\\
		SUB	k,s,n		 	 A 	& $\.K.\is \.SIZE(P).-\.N.$.
		BNN	k,A4		 	 A\bg{1} & Jump if $\.SIZE(P).\ge \.N.$.
1H		LDTU	p,rlink,p	 	 A+B-1 	 & $\.P.\is \.RLINK(P).$.
%%%
A2		PBNZ	p,A3			\kern -3ex A+B\bg{B} &\ut  A2. End of list?\\
		BNZ	f,9F		 	B\bg{0}   &Overflow if $\.P.=0$ and $\.F.\ne 0$.
		SET	f,1		 	B 	  &$\.F.\is 1$.
		JMP	1B		 	B 	  &
%%%
A4		LDTU	:rover,p,rlink		1	  &\ut  A4\mm. Reserve at least \.N..\\ 
		CMP	t,k,c		 	1 	  &
		BNN	t,1F		 	1\bg{1-D} &Jump if $\.K.\ge c$.
%%%	Delete
		LDTU	q,llink,p		D	&Delete \.NODE(P). from list.
		STTU	:rover,rlink,q	 	D 	&
		STTU	q,llink,:rover	 	D 	&
		SET	l,p		 	D 	&Result is \.P..
		SET	n,s		 	D 	&Size of result is size of \.P..
		JMP	2F		 	D 	&
%%%	Split
1H		ADDU	l,p,k			1-D	&Split \.NODE(P). into \.P. and \.L.\hair.
		STTU	k,size,p	 	1-D 	&$\.SIZE(P).\is \.K.$.
		STTU	k,psize,l		1-D 	&$\.SIZE(P).\is \.K.$ at block end.
%%%
2H		OR	n,n,1			1 	&
		STTU	n,size,l 		1 	&$\.SIZE(L).\is \.N.$, $\.TAG(L).\is 1$.
		ADDU	q,l,n		 	1 	&Advance to block after \.L.\hair.
		STTU	n,psize,q	 	1 	&$\.SIZE(L).\is \.N.$,$\.TAG(L).\is 1$.
%%%
		ADDU	$0,rlink,l		1	&Return absolute address
		POP	1,0		       	  	&\qquad  of usable memory.
%%%
9H		POP	0,0				& Overflow.\quad\slug
%%%rt  2.5ex13.rt & (23+5A+7B+D)\upsilon + (4+2A+B+D)\mu
%%%off	
		PREFIX	: