%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2/ex11.mms
%	Author:	Martin Ruckert
%	Title:	Exercise 11
%	5.2 exercise 11 page 617
	PREFIX	:reorder:

:reorder	IS	@

key	IS	$0	
p	IS	$1	
n	IS	$2
i	IS	$3	
j	IS	$4	
ii	IS	$5	
jj	IS	$6	
k	IS	$7	
kk	IS	$8	
rk	IS	$9	
pi	IS	$10	
pj	IS	$10	Shares a register with pi.
t	IS	$11     
eq	IS	$12	
%%%on
P1	SET	i,n		1 & \ut  P1. Loop on $i$.\\
	JMP	0F		1 &
P2	SL	ii,i,3		N & \foolit{p}\ut  P2. Is \setxfool($i$)${}=i$?\\
	LDO	pi,p,ii		N &
	CMP	eq,pi,i		N &
	BZ	eq,0F		N\bg{N-(A-B)} & Jump if $p(i)=i$.
	LDO	t,key,ii		A-B & \ut  P3. Begin cycle.\\ $t\is R_i$.
	SET	j,i; SET jj,ii	A-B &$j \is i$.
P4	LDO	k,p,jj		N-A & \subfoolit{j}\ut  P4. Fix $R$\setfool.\\ $k \is p(j)$.
	SL	kk,k,3		N-A &
	LDO	rk,key,kk		N-A &
	STO	rk,key,jj		N-A & $R_j \is R_k$.
	STO	j,p,jj		N-A & $p(j) \is j$.
	SET	j,k; SET jj,kk	N-A & $j \is k$.
	LDO	pj,p,jj		N-A &
	CMP	eq,pj,i		N-A &
	PBNZ	eq,P4		N-A\bg{A-B} & Repeat if $p(j)\ne i$.
	STO	t,key,jj		A-B & \ut  P5. End cycle.\\ $R_j\is t$.
	STO	j,p,jj		A-B & $p(j) \is j$.
0H	SUB	i,i,1		N+1 &
	PBNN	i,P2		N+1\bg{1} & $N>i\ge 0$.\quad\slug
%%%rt 5.2ex11.rt & (18N-5A-5B+6)\upsilon + (6N -2A -3B)\mu
%%%off
	POP	0,0
	
	PREFIX	:
%%%on