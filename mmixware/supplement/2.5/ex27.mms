%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.5/ex27.mms
%% exercise 2.5-27
%	Author:	M. Ruckert
%	Title:	Exercise 27, Allocate
%% we us this layout four TETRA: kval,linkf,linkb,Unused for free Blocks
%% see 2.5 \eq(7)



%%	Global register holds address of list heads
tags	GREG	0	Address of tag memory
base	GREG	0	Base address of available Memory
kval	IS	base

	PREFIX	:Init:

j	IS	$0
linkf	IS	$1
linkb	IS	$2
p	IS	$3
t	IS	$4
kval	IS	:base

:Init	SETH	:tags,#4000		Pool Segment
	LDOU	:tags,:tags,0		Free memory
%%%
	SET	t,1
	SL	t,t,:m-4-3		Number of bytes for tags
	ADD	t,t,8			Space for the sentinel tag bit.
	ADDU	:base,:tags,t		Allocate space for tags
1H	SUB	t,t,8
	STCO	0,:tags,t
	BP	t,1B
%%%
	ADDU	:base,:base,15	
	ANDN	:base,:base,15		Round up to multiple of 16
	SET	t,:m
	SUB	t,t,4			k >= 4
	16ADDU	:base,t,:base		Make Space for m heads	
	ADDU	linkf,:base,4
	ADDU	linkb,:base,8
%%%
	NEG	j,4,:m			k>=4
	SL	j,j,4
1H	STTU	j,j,linkb		Make empty list heads
	STTU	j,j,linkf
	ADD	j,j,16
	BN	j,1B
%%%
	SUB	j,j,16			Put the big block on the list.
	SET	p,0
	STTU	p,j,linkb
	STTU	p,j,linkf
	STTU	j,p,linkb
	STTU	j,p,linkf
	NEG	t,16			$t\is \.AVAIL[$m$].$.
	STT	t,p,kval
	SETH	t,#8000
	STOU	t,:tags,0
%%%
	POP	0,0	



		PREFIX	:Reserve:
k		IS	$0	2^k Bytes must be reserved 4<=k<=m
availj		IS	$1
l		IS	$3
kval		IS	:base
linkb		IS	$4
linkf		IS	$5
availk		IS	$6
rJ		IS	$7
p		IS	$8
jk		IS	$9
bitk		IS	$10
t		IS	$11

KVAL		IS	0
LINKF		IS	4
LINKB		IS	8

%%%on
:Allocate	ADDU	linkf,:base,LINKF	1 	& 			
		ADDU	linkb,:base,LINKB	1 	&
		CMP	t,k,4		 	1 	&
		CSN	k,t,4		 	1 	&	$k\is\max\{k,4\}$.
		NEG	availk,16*(:m+1) 	1 	&	$\.availk.\is \.LOC(AVAIL[$0$]).$.
		16ADDU	availk,k,availk  	1 	&	$\.availk.\is \.LOC(AVAIL[$k$]).$.
		SET	availj,availk		1 	&	\ut R1. Find block.\\ $j\is k$.
1H		LDT	l,availj,linkf	 1+R &	$\.L.\is \.availF[$j$].$.	
		PBNN	l,R2		 1+R\bg{R} &	To R2 if $\.L.\ne \.AVAIL[$j$].$.
		ADD	availj,availj,16	 R &	$j\is j+1$.
		PBN	availj,1B		 R\bg{0} &	Is $j\le m$?
		POP	0,0		 0 &	Return $\Lambda$.
%%%
R2		GET	rJ,:rJ		 1 &	\ut R2. Remove from list.\\
		LDT	p,l,linkf	 1 &	$\.P.\is\.LINKF(L).$.
		STT	p,availj,linkf	 1 &	$\.availF[$j$].\is \.P.$.
		STT	availj,p,linkb	 1 &	$\.LINKB(P).\is \.LOC(AVAIL[$j$]).$.
%%%
		SET	t+1,l		 1 &
		PUSHJ	t,:FindTag	 1 & 	Find $\.TAG(L).$.
		ANDN	t,t,t+1		 1 &	Set tag bit to zero. 
		STOU	t,:tags,t+2	 1 &	$\.TAG(L).\is 0$.
%%%		
		SUB 	jk,availj,availk  1 & 	\ut R3. Split required?\\
		SR	jk,jk,4		 1  &	 $\.jk.\is j-k$.
		PBZ	jk,9F		 1\bg{R^\prime} & Terminate if $j=k$.
%%% The next two instructions could be moved before the PBZ, this way R^\prime would cancel in the analysis
		SET	bitk,1		 R^\prime & $\.bitk.\is 2^0$.
		SL	bitk,bitk,k	 R^\prime &	$\.bitk.\is 2^k$.
%%%
R4		SUB	jk,jk,1		 R &	\ut R4. Split.\\ $j\is j-1$.
		SL	t,bitk,jk	 R & $\.t.\is 2^j$.
		ADDU	p,l,t		 R &	$\.P.\is \.L.+2^j$.
%%%
		SET	t+1,p		 R &
		PUSHJ	t,:FindTag	 R & Find $\.TAG(P).$.
		OR	t,t,t+1		 R &	Set tag bit to one.
		STOU	t,:tags,t+2	 R &	$\.TAG(P).\is 1$.
		16ADDU  availj,jk,availk  R & Get \.LOC(AVAIL[$j$])..
		STT	availj,p,kval	 R &	$\.KVAL(P).\is \.LOC(AVAIL[$j$]).$.
		STT	availj,p,linkf	 R &	$\.LINKF(P).\is \.LOC(AVAIL[$j$]).$.
		STT	availj,p,linkb	 R &	$\.LINKB(P).\is \.LOC(AVAIL[$j$]).$.
		STT	p,availj,linkf	 R &	$\.availF[$j$].\is \.P.$.
		STT	p,availj,linkb	 R &	$\.availB[$j$].\is \.P.$.
		BP	jk,R4		 R\bg{R-R^\prime} & Repeat if $j>k$.
%%
9H		ADDU	$0,:base,l	 1 &	Return \.L. as absolute address.
		PUT	:rJ,rJ	 	1 &
		POP	1,0		  &	\slug
%%% currently no ^ in rtrefs
%%%rt 2.5ex27.rt & (22+22R+2R^\prime)\upsilon+ (5+7R)\mu
%%%off
