%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.1/ex33.mms
%	Author:	B. Hegerle <bhegerle@ea...>
%	Title:	Exercise 33, Improved List insertion sort
% 		Edited by  Martin Ruckert
%       removing two CMPU to zero
%	CMPU	t,p,0		% Is p > 0?
%	CMPU	t,j,0		% Is j > 0?
%       merging the Key and Link arrays 
% MMIX Program for Algorithm 5.2.1L: List insertion sort.  
% 2005-11-22 21:41

  	PREFIX	:Sort:
link	IS	$0      Parameter
n	IS	$1	$N$

key	IS	$2
j	IS	$3	Local variables
p	IS	$4	
q	IS	$5	
k	IS	$6	
kp	IS	$7	
t	IS	$9	
LINK	IS	0
KEY	IS	8

%%%on
:Sort		ADDU	key,link,KEY		1 &\foolit{j}\ut  L1. Loop on \setfool.\\
		SL	j,n,4			1 & $j\is N$.
		NEG	t,1;	SRU	t,t,1	1 & $\.t.\is{}$the largest signed 64-bit number.
		STO	t,key,0			1 & $K_0\is \infty$.\quad \.;-).
		STOU 	j,link,0		1 & $L_0\is N$.
		STCO	0,link,j		1 & $L_N\is 0$.
		JMP	0F			1 & Go to decrease $j$.
%%%
L2		SET	q,0			N-1 & \otherfoolit{p}\foolit{q}\ut  L2. Set up \setotherfool, \setfool, $K$.\\ $p\is L_0$.
		LDO	k,key,j			N-1 & $K\is K_j$.
%%%

4H		LDOU	p,link,q		B^\prime & \otherfoolit{p}\foolit{q}\ut  L4. Bump \setotherfool, \setfool.\\
%%%
		LDO 	kp,key,p		B^\prime &  \subfoolit{p}\ut  L3. Compare $K:K$\setfool.\\
		CMP	t,k,kp			B^\prime &
		BNP	t,L5			B^\prime\bg{N^\prime} & To L5 if $K\le K_p$.
%%%
		LDOU	q,link,p		B^{\prime\prime} & \otherfoolit{q}\foolit{p}\ut  L4. Bump \setotherfool, \setfool.\\
%%%
		LDO 	kp,key,q		B^{\prime\prime}&  \subfoolit{q}\ut  L3. Compare $K:K$\setfool.\\
		CMP	t,k,kp			B^{\prime\prime} &
		PBP	t,4B			B^{\prime\prime}\bg{N^{\prime\prime}} & To L5 if $K\le K_q$.
%%%
%%%
		STOU	j,link,p		N^{\prime\prime} & \ut  L5. Insert into list.\\ $L_p\is j$.
		STOU	q,link,j		N^{\prime\prime} & $L_j\is q$.
%%%
0H		SUB	j,j,16			N^{\prime\prime}+1 &$j\is j-1$.
		PBP	j,L2			N^{\prime\prime}+1 \bg{A^\prime} &$N>j\ge1$.
%%%
		POP	1,0
L5		STOU	j,link,q		N^\prime & \ut  L5. Insert into list.\\ $L_q\is j$.
		STOU	p,link,j		N^\prime & $L_j\is p$.
%%%
0H		SUB	j,j,16			N^\prime &$j\is j-1$.
		PBP	j,L2			N^\prime \bg{A^{\prime\prime}} &$N>j\ge1$.
%%%%rt 5.2.1ex33.rt & (4B^\prime+4B^{\prime\prime}+2N+ 6N^\prime+6N^{\prime\prime}+ 2A^\prime+2A^{\prime\prime}+6)\upsilon + (2B^\prime+2B^{\prime\prime} +1N +2N^\prime+2N^{\prime\prime}+2)\mu
		POP	1,0			       &\slug
%%%off
%%%%
		PREFIX	: