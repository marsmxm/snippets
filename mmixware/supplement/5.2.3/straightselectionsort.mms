%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.3/straightselectionsort.mms
%	Author:	Michael Unverzart
%	Title:	Program S, Straight selection sort -
% Version 1.3
  	  PREFIX	:sort:
% parameter
key	IS	$0		base address
n	IS	$1		number of elements
% local variables
j	IS	$2		scaled 		index (offset) S1: loop on j
k	IS	$3		scaled 		index (offset) S2: find max
kk	IS	$4		element at index k (Kk)
i	IS	$5		scaled		current maximum offset
max	IS	$6		current maximum element (Ki)
t	IS	$7		
%%%on
:Sort	SL	j,n,3		 1 & \foolit{j}\ut  S1. Loop on \setfool.\\ $j\is N$.
	JMP	1F		 1 & 	  
%%%
2H	SET	k,j		 N-1 & \subfoolit{j}\ut  S2. Find $\max$($K_1$, \dots, $K$\setfool).\\
	SET	i,j		 N-1 & $i\is j$.
	LDO	max,key,i		 N-1 & $\.max. \is K_i$.
%%%
3H	SUB	k,k,8		 A & Loop on $k$.
	LDO	kk,key,k		 A &  $\.kk. \is K_k$.
	CMP	t,max,kk		 A & Compare $\.max. :K_k$.
	PBNN	t,0F		 A\bg{B} & If $\.max. <K_k$,
	SET	i,k		 B & \quad $i\is k$ and
	SET	max,kk		 B & \quad $\.max.\is K_k$.
%%%
0H	PBP	k,3B		 A\bg{N-1} & Repeat if $k>0$.
%%%
	LDO	t,key,j		 N-1 &\subfoolit{j} \ut  S3. Exchange with $R$\setfool.\\
	STO	max,key,j		 N-1 & 
	STO	t,key,i		 N-1 & 
%%%
1H	SUB	j,j,8		 N & Decrement $j$.
	PBP	j,2B		 N\bg{1} & $N> j> 0$.\quad\slug
%%%off
	POP	0,0
%%%
	PREFIX	:
