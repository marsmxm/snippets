%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.3.1/proga.mms
%	Author:	M.Ruckert
%	Title:	Program A, Addition of nonnegative integers

	PREFIX	:Classic:

%%%	Parameter	
u	IS	$0
v	IS	$1
w	IS	$2
n	IS	$3	$n$
%%%	Local variables.
j	IS	$4	
k	IS	$5	$k$
wj	IS	$6	$w_j$
t	IS	$7	$t$
%%%on
:Add	8ADDU	u,n,u			 1 & \ut A1. Initialize.\\ $\.u.\is \.u.+8n$.
	8ADDU 	v,n,v			 1 & $\.v.\is \.v.+8n$.
	8ADDU 	w,n,w			 1 & $\.w.\is \.w.+8n$.
	SL	j,n,3; NEG j,j    	 1 &	 $j \is 0$.
	SET	k,0   	   	  	 1 &	$k \is 0$.
A2	LDOU	t,u,j; ADDU wj,t,k	 N &	\ut A2. Add digits.\\ $w_j\is u_j+k$.
	ZSZ 	k,wj,k			 N &	Carry?
	LDOU	t,v,j; ADDU wj,wj,t	 N &	$w_j\is w_j+v_j$.
	CMPU	t,wj,t; CSN k,t,1	 N &	Carry?
	STOU	wj,w,j			 N &
	ADD	j,j,8			 N &	\foolit{j}\ut A3. Loop on \setfool.\\ $j\is j+1$.
	PBN	j,A2			 N\bg{1} &	Probably $j<n$.
	STOU	k,w,j			 1 &	$w_n\is k$.
%%%
	POP	0,0			   &\slug
%%%rt 4.3.1proga.rt & 9\upsilon + 1\mu + N(10\upsilon + 3\mu)
%%%off
