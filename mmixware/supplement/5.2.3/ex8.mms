%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.3/ex8.mms
%	Author:	Michael Unverzart
%	Title:	Exercise 8, Straight selection sort
% Version 1.3
  	  PREFIX	:sort:
% parameter
key	IS	$0			base address
n	IS	$1			number of elements
link	IS	$2			Links
% local variables
j	IS	$3		scaled		index (offset) S1: loop on j
k	IS	$4		scaled		index (offset) S2: find max, k relative to Kj
kk	IS	$5			element at index k (Kk)
i	IS	$6		scaled		current maximum offset
max	IS	$7			current maximum element (Ki)
keyj	IS	$8		
linkj	IS	$9		
t	IS	$10		
%%%on
:Sort	SL	j,n,3		 1 & \foolit{j}\ut  S1. Loop on \setfool.\\ $j\is N$.
	SUB	j,j,8		 1 & $j\is j-1$.
	BNP	j,9F		 1\bg{0} & $j>0$?	  
	NEG	t,1		 1 & 
	STO	t,link,0		 1 & $L_1\is -1$.
	JMP	1F		 1 &
%%%
2H	ADDU	linkj,link,j		 N-D & $\.linkj.\is\.LOC($L_{j+1}$).$.
	ADDU	keyj,key,j		 N-D & $\.keyj.\is\.LOC($K_{j+1}$).$.
S2	LDO	kk,keyj,k		 A & \subfoolit{j}\ut  S2. Find $\max$($K_1$, \dots, $K$\setfool).\\  $\.kk. \is K_k$.
	CMP	t,max,kk		 A & Compare $K_i:K_k$.
	PBNN	t,0F		 A\bg{N-C} & If $K_i<K_k$,
	STO	i,linkj,k		 N-C & \qquad $L_k\is i$,
	ADD	i,j,k		 N-C & \qquad $i\is k$, and
	SET	max,kk		 N-C & \qquad $\.max.\is K_k$.
%%%
0H	ADD	k,k,8		 A & $k\is k+1$.
	PBNP	k,S2		 A\bg{N-D} & Jump if $k\le j$.
%%%
S3	LDO	t,key,j		 N-1 &\subfoolit{j} \ut  S3. Exchange with $K$\setfool.\\
	STO	max,key,j		 N-1 & 
	STO	t,key,i		 N-1 & 
	SUB	j,j,8		 N-1 & $j\is j-1$.
%%%
	SUB	k,i,j		 N-1 & $k \is i $.
	LDO	i,link,i		 N-1 & $i \is L_i$.
	PBNN	i,0F		 N-1 \bg{C-1} & If there is no link,
1H	NEG	k,8,j		 C & \qquad $k\is 1$ and
	SET	i,0		 C & \qquad $i\is 0$.
0H	LDO	max,key,i		 N & $\.max. \is K_i$.
	PBNP	k,2B		 N \bg{D}&
	PBP	j,S3		 D \bg{1}&
%%%
9H	POP	0,0		   &\slug
%%%off
	PREFIX	:
