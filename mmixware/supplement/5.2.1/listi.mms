%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.1/listi.mms
%	Author:	B. Hegerle <bhegerle@ea...>
%	Title:	Program L, List insertion
% 	Edited by  Martin Ruckert
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
		STOU 	j,link,0		1 & $L_0\is N$.
		STCO	0,link,j		1 & $L_N\is 0$.
		JMP	0F			1 & Go to decrease $j$.
%%%
L2		LDOU	p,link,0		N-1 & \otherfoolit{p}\foolit{q}\ut  L2. Set up \setotherfool, \setfool, $K$.\\ $p\is L_0$.
		SET	q,0			N-1 & $q\is 0$.
		LDO	k,key,j			N-1 & $K\is K_j$.
%%%
L3		LDO 	kp,key,p		B+N-1-A &  \subfoolit{p}\ut  L3. Compare $K:K$\setfool.\\
		CMP	t,k,kp			B+N-1-A &
		BNP	t,L5			B+N-1-A\bg{N-1-A} & To L5 if $K\le K_p$.
%%%
		SET	q,p			B &\otherfoolit{q}\foolit{q}\ut  L4. Bump \setotherfool, \setfool.\\ $q\is p$.
		LDOU	p,link,q		B & $p\is L_q$.
		PBNZ	p,L3			B\bg{A} &To L3 if $p\ne 0$.
%%%
L5		STOU	j,link,q		N-1 & \ut  L5. Insert into list.\\ $L_q\is j$.
		STOU	p,link,j		N-1 & $L_j\is p$.
%%%
0H		SUB	j,j,16			N &$j\is j-1$.
		PBP	j,L2			N \bg{1} &$N>j\ge1$.\quad\slug
%%%rt 5.2.1listi.rt & (6B+12N-3A-3)\upsilon + (2B +5N -A -3)\mu
%%%off
		POP	1,0
%%%
		PREFIX	: