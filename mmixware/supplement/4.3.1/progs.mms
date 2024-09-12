%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.3.1/progs.mms
%	Author:	M.Ruckert
%	Title:	Program S, Subtraction of nonnegative integers
	PREFIX	:Classic:

u	IS	$0	Parameter.
v	IS	$1
w	IS	$2
n	IS	$3

j	IS	$4	Local variables.
k	IS	$5
wj	IS	$6
vj	IS	$7
uj	IS	$8
t	IS	$9
%%%on
:Sub	8ADDU	u,n,u			 1 & \ut S1. Initialize.\\ 
	8ADDU 	v,n,v			 1 & 
	8ADDU 	w,n,w 			 1 & 
	SL	j,n,3; NEG j,j    	 1 & $j \is 0$.
	SET	k,0   	   	  	 1 & $k \is 0$.
%%%
S2	LDOU	uj,u,j			 N &	\ut S2. Subtract digits.\\
	SUBU 	wj,uj,k	 		 N &	$w_j\is u_j-k$.
	CSNZ 	k,uj,0			 N &	Borrow!
	LDOU	vj,v,j 			 N &
	CMPU	t,wj,vj; CSN k,t,1	 N &	Borrow?\lineref|4.3.1borrow|\lineref|4.3.1ex10a|
	SUBU 	wj,wj,vj		 N &	$w_j\is w_j-v_j$.\lineref|4.3.1ex10b|
	STOU	wj,w,j			 N &
	ADD	j,j,8			 N &	\ut S3. Loop on {\it j}.\\ $j\is j+1$.
	PBN	j,S2			 N\bg{1} &	Probably $j < n$. 
	BNZ	k,:Error			 1\bg{0} &	$k\ne 0$ only if $u<v$.
%%%
	POP	0,0				&\slug
%%%rt 4.3.1progs.rt & 9\upsilon + N(10\upsilon + 3\mu)
%%%off
