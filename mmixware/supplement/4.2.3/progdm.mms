%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.2.3/progdm.mms
%	Author:	M.Ruckert
%	Title:	Exercise 4, Double-precision floating point multiplication
	PREFIX	:DFmul:
um	IS	$0	1. parameter
ul	IS	$1	1. parameter
vm	IS	$2	2. parameter
vl	IS	$3	2. parameter

wm	IS	$4	return value
wl	IS	$5	return value

s	IS	$6	sign of w
e	IS	$7	exponent of w
carry	IS	$8	The shuttle between $x_m$, $x_l$.

eu	IS	$9	exponent of u
ev	IS	$10	exponent of v
t	IS	$11

%%%on
:DFmul	SLU	eu,um,1; SLU	ev,vm,1		 \ut  M1. Unpack.\\
	SRU	eu,eu,49; SRU	ev,ev,49	       		       
	XOR	s,um,vm; SRU	s,s,63		 $s \is s_u\times s_v$.
	ANDNH	um,#FFFF; ORH   um,#0001 	^{ORH+<ORH> (bitwise or with high wyde)}
	ANDNH	vm,#FFFF; ORH   vm,#0001 	^{ANDNH+<ANDNH> (bitwise and-not high wyde)}
%%%
	SLU	um,um,8				Shift $(u_m,u_l)$ left.		
        SRU	carry,ul,64-8
	ADDU 	um,um,carry 
	SLU	ul,ul,8			
	SLU	vm,vm,8				Shift $(v_m,v_l)$ left.	
        SRU	carry,vl,64-8
	ADDU vm,vm,carry 
	SLU	vl,vl,8
%%%
%%%
%%%							
	MULU	t,um,vl					\ut  M2. Operate.\\ 
	GET 	wl,:rH 					$\.wl. \is 2^{56}u_m\times 2^{64}v_l\times 2^{-64}$.
	MULU	t,ul,vm 
	GET     t,:rH; ADDU wl,wl,t			$\.wl. \is \.wl. + 2^{56}u_lv_m$.
	MULU	t,um,vm; GET wm,:rH			$\.wm. \is \lfloor 2^{48}u_m\times v_m\rfloor$.\lineref|4.2.3bigmul|
	ADDU	wl,wl,t	     				$\.wl. \is \.wl. +\.um.\times\.vm.\mod 2^{64}$.
	CMPU	t,wl,t; ZSN carry,t,1			$\.carry. \is 1$ if $\.wl.+\.t.<\.t.$.
	ADDU	wm,wm,carry
	ADD	e,eu,ev
	SET 	t,#3FFF; SUB e,e,t			$e\is e_u+e_v-q$.
%%%
	JMP	:DNormalize		    		\ut  M3. Normalize.\\\quad\slug
%%%off  
       %32 instructions
