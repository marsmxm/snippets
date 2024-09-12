%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.5/ex28.mms		
%	Author:	M.Ruckert
%	Title:	Exercise 28, Free
		PREFIX	:Free:
l		IS	$0
k		IS	$1
p		IS	$2
q		IS	$3
r		IS	$4
%%%no		IS	$5
%%%nb		IS	$6
%%%b		IS	$7
kval		IS	:base
linkb		IS	$8
linkf		IS	$9
rJ		IS	$10
availk		IS	$11
t		IS	$12
KVAL		IS	0
LINKF		IS	4
LINKB		IS	8

%%%on
:Free		GET	rJ,:rJ		 1 &
		ADDU	linkf,:base,LINKF	 1 &		
		ADDU	linkb,:base,LINKB	 1 &
		CMP	t,k,4		 1 &
		CSN	k,t,4		 1 &	$k\is\max\{k,4\}$.
		SUBU	l,l,:base	 1 &	Make \.L. a relative address.
		SUB	availk,k,:m+1	 1 &	
		SLU	availk,availk,4		 1 &	$\.availk.\is\.LOC(AVAIL[$k$]).$.		
%%%	
S1		SET	t,1		 1+S &	\ut S1. Is buddy available?\\
		SLU	t,t,k		 1+S &	$\.t.\is 2^k$.
		XOR	p,l,t		 1+S &	$P \is \hbox{buddy}_k(\.L.)$.
%%%
		SET	t+1,p		 1+S &
		PUSHJ	t,:FindTag	 1+S & Find $\.TAG(P).$.
		AND	t,t,t+1		 1+S & Extract  $\.TAG(P).$.
%%% 						This catches also the case k=m
		PBZ	t,S3		 1+S\bg{B} &	To S3 if $\.TAG(P).=0$.
%%%
		LDT	t,p,kval	 B+S & $\.t.\is \.KVAL(P).$.	
		CMP	t,t,availk	 B+S & $\.KVAL(P).=k$?
		PBNZ	t,S3		 B+S\bg{S} &	To S3 if  $\.KVAL(P).\ne k$.
%%%
		LDT	r,p,linkf	 S &	\ut S2. Combine with buddy.\\
		LDT	q,p,linkb	 S &	 $\.R.\is \.LINKF(P).$; $\.Q.\is \.LINKB(P).$.
		STT	r,q,linkf	 S &	$\.LINKF(LINKB(P)).\is \.LINKF(P).$.
		STT	q,r,linkb	 S &	$\.LINKB(LINKF(P)).\is \.LINKB(P).$.
		ADD	k,k,1		 S & Increase $k$.
		ADD	availk,availk,16	 S &
		AND	l,l,p		 S &	If $\.L.>\.P.$, set $\.L.\is \.P.$.
		JMP	S1		 S &
%%%
S3		SET	t+1,l		 1 &	\ut S3. Put on list.\\ 
		PUSHJ	t,:FindTag	 1 & Find $\.TAG(L).$.
		OR	t,t,t+1		 1 &	Set tag bit to one.
		STOU	t,:tags,t+2	 1 &	$\.TAG(L).\is 1$.
		LDT	p,availk,linkf	 1 &	$\.P.\is \.AVAILF[$k$].$.	
		STT	p,l,linkf	 1 &	$\.LINKF(L).\is \.P.$.
		STT	l,p,linkb	 1 &	$\.LINKB(P).\is \.L.$.
		STT	availk,l,kval	 1 &	$\.KVAL(L).\is k$.
		STT	availk,l,linkb	 1 &	$\.LINKB(L).\is \.LOC(AVAIL[$k$]).$.
		STT	l,availk,linkf	 1 &	$\.AVAILF[$k$].\is \.L.$.
		PUT	:rJ,rJ	 1 &
		POP	0,0		   &	\slug
%%%rt 2.5ex28.rt & (26+20S+5B)\upsilon+(7+5S+B)\mu
%%%off
%%%	
		PREFIX	:	
