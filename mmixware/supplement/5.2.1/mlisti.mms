%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.1/mlisti.mms
%	Author:	Martin Ruckert
%	Title:	Program M, Multiple list insertion
%		modified from program L
	PREFIX	:MListSort:
link	IS	$0	Parameter
n	IS	$1	
head	IS	$2	
m	IS	$3	
e	IS	:e	

key	IS	$4	
j	IS	$5	scaled Local variables
p	IS	$6	
q	IS	$7	
k	IS	$8	
kp	IS	$9	
i	IS	$10	scaled	
t	IS	$11	
LINK	IS	0
KEY	IS	8

%%%on
:Sort		SL 	i,m,3			 1 & $i\is M$. 
		JMP	1F			 1 &
0H		STCO	0,head,i		 M & Clear heads.\lineref|5.2.1-mlisti-init|^{STCO+<STCO> (store constant octabyte)}
1H		SUB	i,i,8			 M+1 &$i\is i-1$.\lineref|5.2.1-mlisti-initend|
		PBNN	i,0B			 M+1\bg{1} &
%%%
		SUBU	head,head,link		 1 & Make \.head. a relative address.
		ADDU	key,link,KEY		 1 & \foolit{j}\ut  M1. Loop on \setfool.\\ 
		SL 	j,n,4			 1 & $j\is N$.
		JMP	0F			 1 &
%%%
M2		LDO	k,key,j			 N & \otherfoolit{q} \foolit{p}\ut  M2. Set up \setfool, \setotherfool, $K$.\\ $K\is K_j$.
		MUL	i,m,k			 N & $i\is M\cdot K_j$.\lineref|5.2.1-mlisti-mul|
		SRU	i,i,e-3			 N & $i\is {\lfloor M\cdot K_j/2^{e}\rfloor}$.\lineref|5.2.1-mlisti-sru|
		ADDU	q,head,i		 N & $q \is \mathop{\hbox{relative address of}} H_i$.
		JMP	4F			 N & Jump to load and test $p$.
%%%
M3		LDO 	kp,key,p		 B+N-A &\subfoolit{p} \ut  M3. Compare $K:K$\setfool.\\
		CMP	t,k,kp			 B+N-A &
		BNP	t,M5			 B+N-A\bg{N-A} & To L5 if $K\le K_p$.
%%%
		SET	q,p			 B & \otherfoolit{p}\foolit{q}\ut  M4. Bump \setotherfool, \setfool.\\ $q\is p$.
4H		LDOU	p,link,q		 B+N & $p\is L_q$.
		PBNZ	p,M3			 B+N\bg{A} & To L3 if $p\ne 0$.
%%%
M5		STOU	j,link,q		 N & \ut  M5. Insert into list.\\  $L_q\is j$.\lineref|5.2.1-mlisti-stotail|
		STOU	p,link,j		 N & $L_j\is p$. \lineref|5.2.1-mlisti-stotailend|
%%%
		SUB	j,j,16			 N &
0H		PBP	j,M2			 N+1\bg{1} & $N>j\ge1$.\quad\slug
%%%rt  5.2.1mlisti.rt	& (6B+25N-3A+3M+13)\upsilon + (2B+5N-A+M)\mu
%%%off
		POP	1,0
%%%
		PREFIX	:

