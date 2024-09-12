%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2/ex12.mms
%	Author:	Martin Ruckert
%	Title: Exercise 12, MacLarens Algorithm

	PREFIX	:MacLaren:


link	IS	$0		\.LOC($R_0$).

p	IS	$1
k	IS	$2		\.LOC($R_k$).
kp	IS	$3	 	\.LOC($R\.[P].$).
q	IS	kp
t	IS	$4	
key	IS	$5
LINK	IS	0
KEY	IS	8

%%%on
M1		LDOU	p,link,0		1 & \ut  M1. Initialize.\\ $\.P.\is \.HEAD.$.
		SET	k,16		1 & $k\is 1$.
		ADDU	key,link,KEY		1 &
		JMP	M2		1 &
%%%
0H		LDOU	p,link,p		A & $\.P.\is \.LINK(P).$.
M3		CMPU	t,p,k		N+A &\ut  M3. Ensure \.P. is at least $k$.\\
		BN	t,0B		N\bg{A} &
%%%	
		LDOU	t,key,k		N & \ut  M4. Exchange.\\
		LDOU	kp,key,p		N & 
		STOU	t,key,p		N &
		STOU	kp,key,k		N &
%%%
	 	LDOU	t,link,k		N &
		LDOU	q,link,p		N & $\.Q.\is \.LINK($k$).$.
		STOU	t,link,p		N &
		STOU	p,link,k	  	N & $\.LINK($k$).\is \.P.$.
%%%
		SET	p,q		N & $\.P.\is \.Q.$.
		ADDU	k,k,16		N & $k\is k+1$.	
%%%
M2		PBNZ	p,M3		N+1\bg{1} & \ut  M2. Done?\\
		POP	0,0		          &\slug
%%%rt 5.2ex12.rt   & (13N+4A+7)\upsilon + (8N+A+1)\mu
%%%off
		PREFIX	: