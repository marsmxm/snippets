%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.5/ex5.mms
%	Author:	M. Ruckert
%	Title:	Exercise 5, Program R improved

	PREFIX :Rsort:

key	IS	$0
n	IS	$1
p	IS	$2
bot	IS	$3

rJ	IS	$4
k	IS	$5
top	IS	$6
P	IS	$7

ti	IS	$8
i	IS	$9
mask	IS	$10
t	IS	$11

LINK	IS	0
KEY	IS	8	Offset to least significant byte of key.
m	IS	:m
M	IS	(1<<m)

%%%rton
:Sort	GET	rJ,:rJ		1 &  First pass.
	SET	t+1,bot		1 &
	PUSHJ	t,:Empty		1 & \ut  R2.~Set piles empty.\\
%%%
	SET	t,M		1 &
	8ADDU	top,t,bot	1 & $\.top.\is \.LOC(TOP[0]).$.
	16ADDU	P,n,key		1 & \ut  R1.~Loop on $k$.\\ $\.P.\is \.LOC($R_{N+1}$).$.
%%%on ex5a.tex
	NEG	k,3			1 & $k \is 1$.
	SET	mask,8*((1<<m)-1)	1 &$\.mask.\is 8(2^m-1)$ (the bit mask).
0H	SUBU	P,P,16			N & \ut  R5.~Step to next record.\\ 
%%%
	LDOU	i,P,KEY			N &\ut R3.~Extract first digit of key.\\
	SLU	i,i,3 			N &
	AND	i,i,mask 		N & $i\is a_1$.
%%%off
%%%rton
	LDOU	ti,top,i 	N &  \ut  R4.~Adjust links.\\ $\.ti.\is \.TOP[$i$].$.
	STOU	P,ti,LINK	N & $\.LINK(TOP[$i$]).\is \.P.$.
	STOU	P,top,i		N & $\.TOP[$i$].\is \.P.$.
	SUB	n,n,1		N & 
	PBP	n,0B		N\bg{1} &
	JMP	R6		1 &  Later passes.
%%%
R2	SET	t+1,bot		P-1 & \ut  R2.~Set piles empty.\\ 
	PUSHJ	t,:Empty		P-1 &
%%%on ex5b.tex
	ADD	k,k,m		P-1 & $k\is k+1$.
R3	LDOU	i,P,KEY 	N(P-1) &\ut R3.~Extract $k$th digit of key.\\
	SRU	i,i,k 		N(P-1) &
	AND	i,i,mask	N(P-1) & $i\is a_{p+1-k}$.
%%%off
%%%rton
	LDOU	ti,top,i	N(P-1) & \ut  R4.~Adjust links.\\ $\.ti.\is \.TOP[$i$].$.
	STOU	P,ti,LINK	N(P-1) &  $\.LINK(TOP[$i$]).\is \.P.$.
	STOU	P,top,i		N(P-1) & $\.TOP[$i$].\is \.P.$.
	LDOU	P,P,LINK	N(P-1) & \ut  R5.~Step to next record.\\
	PBNZ	P,R3		N(P-1)\bg{P-1} &
%%%
R6	SET	t+1,bot		P & \ut  R6.~Do Algorithm H.\\
	PUSHJ	t,:Hook		P & 
	LDOU	P,bot,0		P & $\.P.\is \.BOTM[0].$.
	SUB	p,p,1		P & \ut  R1.~Loop on $k$.\\
	PBP	p,R2		P\bg{1} &
%%%
	PUT	:rJ,rJ		1 &
	POP	0,0
%%%off	
	PREFIX	:

