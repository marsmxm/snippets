%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.3.1/progm.mms
%	Author:	M.Ruckert
%	Title:	Program M, Multiplication of nonnegative integers
	PREFIX	:Classic:

u	IS	$0	Parameter.
v	IS	$1
w	IS	$2
wj	IS	w	Reusing register w
m	IS	$3
n	IS	$4

i	IS	$5	Local variables.
j	IS	$6
k	IS	$7
vj	IS	$8
wij	IS	$9
c	IS	$10
t	IS	$11

%%%on
:Mul	8ADDU	u,m,u;	8ADDU 	v,n,v	 1 & \ut  M1. Initialize.\\
	SL	j,n,3; NEG j,j		 1 & $j \is 0$. 
	8ADDU	wj,m,w	     	 	 1 & $\.wj.\is\.LOC($w_j$).+8m$.
	SL	i,m,3; NEG i,i		 1 & $i\is 0$.
0H	STCO	0,wj,i 	   	 	 M & $(w_{m-1}\ldots w_0)\is (0\ldots0)$.^{STCO+<STCO> (store constant octabyte)}
	ADD	i,i,8			 M & $i\is i+1$.
	PBN	i,0B			 M\bg{1} & Loop for $0\le i < m$.
%%%
M2	SET	k,0 	   		 N &  \ut  M2. Zero multiplier?\\
	LDOU	vj,v,j	   		 N &
	BZ	vj,6F			 N\bg{Z} &  If $v_j=0$, set $w_{j+m}\is 0$.\lineref|4.3.1M2|
%%%
	SL	i,m,3; NEG i,i		 N-Z & \ut  M3. Initialize i.\\ $i\is 0$.
%%%					%
M4	LDOU	t,u,i			 (N-Z)M & \ut  M4. Multiply and add.\\
	MULU	t,t,vj			 (N-Z)M & $t\is u_i\times v_i$.
	ADDU 	t,t,k			 (N-Z)M & $t\is u_i\times v_i + k$.
	CMPU	c,t,k; ZSN    k,c,1	 (N-Z)M & Carry?
	LDOU	wij,wj,i      		 (N-Z)M & 
	ADDU	t,t,wij			 (N-Z)M & $t\is u_i\times v_i + k+ w_{i+j}$.
	CMPU	c,t,wij; CSN 	k,c,1	 (N-Z)M & Carry?
	STOU	t,wj,i	   		 (N-Z)M & $w_{i+j}\is t \mod b$.
	GET	t,:rH; ADDU	k,k,t	 (N-Z)M & $k\is \lfloor t/b \rfloor$.
	ADD	i,i,8			 (N-Z)M & \ut  M5. Loop on $i$.\\ $i\is i+1$.
	PBN	i,M4			 (N-Z)M\bg{N-Z} &
%%%
6H	STOU	k,wj,0			 N-Z & $w_{j+m}\is k$.
	ADD	wj,wj,8			 N & \foolit{j}\ut  M6. Loop on \setfool.\\
	ADD	j,j,8		 	 N &  $j\is j+1$.
	PBN	j,M2			 N\bg{1} & 
%%%	there should be no carry here
%%%	STOU	k,wj,0			 1 & $w_{j+m}\is k$.
%%%rt 4.3.1progm.rt & (23M\!N+ 3M + 11N + 11 -Z(23M+3))\upsilon + (3M\!N+M+2N-Z(3M+1))\mu
	POP	0,0			&\slug
%%%off