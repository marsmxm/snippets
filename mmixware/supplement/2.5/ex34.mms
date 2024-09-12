%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.5/ex34.mms
%	Author:	Chan Vinh VONG <chanvinh.vong@gmail.com>
%	Title:	Exercise 34, Garbage Collection and Compacting
% Draft Version 2012 April 12th

% Calling Sequence:
%     PUSHJ $0,GC
%
% Global Variables:
%     :AVAIL the top of the allocated nodes in the stack
%     :use   the starting node in use
%     :base  the base of the stack
%


	PREFIX :GC:

top	IS	$0
p	IS	$1
q	IS	$2
k	IS	$3
l	IS	$4 	Pointer to Links(P)
s	IS	$5
ps	IS	$6
size	IS	$7 	Field offset for size
t	IS	$8 	Field offset for T
link	IS	$9	Field offset for Link
st	IS	$10
x	IS	$11	&^{x+<x> (temporary variable)}

%%%on
:GC	NEG	size,16	 1	&Field offset for \.SIZE.
	NEG	t,12		 1	&Field offset for \.T.
	NEG	link,8	 1	&Field offset for \.LINK.
	SET	top,:avail	 1	&\ut G2. Initialize marking phase.\\ 
	STCO	0,:avail,link	 1	&$\.LINK(AVAIL). \is \Lambda$.
	BZ	:use,G3		 1\bg{0}& If $\.USE.\ne\Lambda$ push it.
	STOU	top,:use,link	 1	&$\.LINK(USE). \is \.TOP.$.
	SET	top,:use	 1	&\\ $\.TOP. \is \.USE.$.
%%%
G3	SET	p,top		 a+1	&\ut G3. Pop up stack.\\ $\.P.\is\.TOP.$.
	LDOU	top,top,link	 a+1	&$\.TOP.\is\.LINK(TOP).$.
	BZ	top,G5		 a+1\bg{1}	&If $\.TOP.=\Lambda$, go to G5.
	LDTU	k,p,t		 a	&\ut G4. Put new links on stack.\\ $k\is\.T(P).$.
1H	BNP	k,G3		 a+b\bg{a}& While $k > 0$ do:
	SUB	k,k,8		 b	&\qquad decrement $k$,	
	LDOU	q,p,k		 b	&\qquad $\.Q.\is \.LINK(P${}+k$).$,
	BZ	q,1B		 b\bg{b^\prime}	&\qquad continue if $\.Q.=\Lambda$,
	LDOU	l,q,link	 b-b^\prime	&\qquad $\.L.\is \.LINK(Q).$,
	BNZ	l,1B		 b-b^\prime\bg{a-1}	&\qquad continue if $\.LINK(Q).\ne\Lambda$,
	STOU	top,q,link	 a-1	&\qquad $\.LINK(Q).\is\.TOP.$, and
	SET	top,q		 a-1	&\qquad $\.TOP.\is \.Q.$.
	JMP	1B		 a-1	&
%%%
G5	SET	q,:base		 1	&\ut G5. Initialize next phase.\\ 
	STOU	q,:avail,link	 1	&$\.LINK(AVAIL).\is \.Q.$.
	STCO	0,:avail,size	 1	&$\.SIZE(AVAIL).,\.T(AVAIL).\is 0$.
	SET	p,:base		 1	&$\.P.\is\.base.$.	
	JMP	G6		 1	&
%%%
1H	STOU	q,p,link	 1	&$\.Q.\is\.LINK(P).$.
	ADDU	q,q,s		 1	&$\.Q.\is \.Q.+\.SIZE(P).$.
	ADDU	p,p,s		 1	&$\.P.\is \.P.+\.SIZE(P).$.
G6	LDOU	l,p,link	 a+1	&$\.L.\is \.LINK(P).$.
G6A	LDTU	s,p,size	 a+c+1	&$\.s.\is \.SIZE(P).$.
	BZ	l,G7		 a+c+1\bg{c}	&To G7 if $\.LINK(P).=\Lambda$.
	PBNZ	s,1B		 a+1\bg{1}	&To G8 if $\.SIZE(P).=0$.	
%%%
G8	BZ	:use,0F		 1	&\ut G8. Translate all links.\\
	LDOU	:use,:use,link	 1	&$\.USE.\is\.LINK(USE).$.
0H	SET	:avail,q	 1	&$\.AVAIL.\is \.Q.$.
	SET	p,:base		 1	&$\.P.\is\.base.$.
	JMP	G8P		 1	&
%%%
1H	LDTU	x,ps,size  	 d	&$\.x.\is \.SIZE(ps).$.
	ADDU	s,s,x  		 d	&$\.s.\is\.s.+ \.SIZE(ps).$.
G7 	ADDU   	ps,p,s  		 c+d	&\ut G7. Collapse available area.\\ 
	LDOU	l,ps,link  	 c+d	& $\.L.\is\.LINK(ps).$.
	BZ	l,1B		 c+d\bg{d}	& Repeat if $\.LINK(ps).=\Lambda$.
	STTU	s,p,size  	 c	&$\.SIZE(P).\is \.s.$.
	ADDU	p,p,s		 c	&$\.P.\is \.P.+\.SIZE(P).$.
	JMP	G6A		 c	&
%%%
2H	SUB	k,k,8		 b	&Decrement $k$.	
	LDOU	q,p,k		 b	&$\.Q.\is \.LINK(P${}+8+k$).$.
	BZ	q,1F		 b\bg{b^\prime}	& Ignore $\Lambda$.
	LDOU	l,q,link	 b-b^\prime	&$\.L.\is\.LINK(Q).$.
	STOU	l,p,k		 b-b^\prime	&$\.LINK(P${}+8+k$).\is \.L.$.
1H	BP	k,2B		 a+b\bg{b}&Jump if $k>0$.		
3H	ADDU	p,p,s		 a+c	&$\.P.\is \.P.+\.SIZE(P).$.
G8P	LDTU	s,p,size	 1+a+c	&$\.s.\is\.SIZE(P).$.	
	LDOU	l,p,link	 1+a+c	&$\.L.\is\.LINK(P).$.
	BZ	l,3B		 1+a+c\bg{c}	&Is $\.LINK(P).=\Lambda$?
	LDTU	k,p,t		 1+a	&$k\is\.T(P).$.
	PBNZ	s,1B		 1+a\bg{1}	&Jump unless $\.SIZE(P).=0$.
%%%
G9	SUBU	p,:base,16	 1	&\ut G9. Move.\\
	SET	q,p		 1	& \.Q. and \.P. start at \.LINK(base)..
	JMP	G9P		 1	&
%%%
1H	STCO	0,q,8		 a	& $\.LINK(Q).\is\Lambda$.
	STOU	st,q,0	 a	& $\.SIZE(Q).,\.T(Q).\is\.SIZE(P).,\.T(P).$.
	ADDU	q,q,s	 a		& $\.Q.\is \.Q.+\.SIZE(P).$.
	NEG	s,16,s	 a		& $\.s.\is 16-\.s.$.
2H	LDOU	x,p,s	 w-2		& Copy data from \.P. to \.Q..
	STOU	x,q,s	 w-2		&
	ADD	s,s,8	 w-2		& $\.s.\is\.s.+8$.
0H	PBN	s,2B		 w-2\bg{a}	&
%%%
G9P	LDOU	l,p,8		 1+a+c		& $\.L.\is\.LINK(P).$.	
	LDOU	st,p,0	 1+a+c		& $\.st.\is\.SIZE(P).,\.T(P).$.	
	SRU	s,st,32	 1+a+c		& $\.s.\is\.SIZE(P).$.
	ADDU	p,p,s	 1+a+c		&$\.P.\is \.P.+\.SIZE(P).$.	
	BZ	l,G9P		 1+a+c\bg{c}	&Jump if $\.LINK(P).=\Lambda$.
	PBNZ	s,1B		 1+a\bg{1}	&Jump unless $\.SIZE(P).=0$.
%%%
	POP	0,0				&\slug
%%%rt 2.5ex34.rt & (35a+14b+4w+23c+7d+37)\upsilon + (12a+5b-3b^\prime+2w+7c+2d+9)\mu

%%%off
%%%

		PREFIX	:Allocate:
s		IS	$0
k		IS	$1
t		IS	$2

:Allocate	CMP	t,k,s
		BP	t,9F
		ADDU	s,s,16+7	add overhead and round up
		ANDN	s,s,7
		ADDU	k,k,7		round up
		ANDN	k,k,7		
		ADD	t,:avail,s
		CMP	t,t,:limit	check for limit
		BNN	t,9F
		NEG	t,8
		STCO	0,:avail,t	set link
		NEG	t,16		
		STTU	s,:avail,t	set size
		NEG	t,12
		STTU	k,:avail,t	set k
		ADDU	:avail,:avail,s	adjust \.AVAIL..
		NEG	t,s		Loop over size
1H		STCO	0,:avail,t	clear memory
		ADD	t,t,8
		BN	t,1B
		SUBU	$0,:avail,s	set return value
		POP	1,0
%%%
9H		POP	0,0		return 0
	PREFIX	:

