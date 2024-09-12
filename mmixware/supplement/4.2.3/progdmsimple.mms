%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.2.3/progdmsimple.mms
%	Author:	M.Ruckert
%	Title:	Program M, Double-precision Multiplication
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
:DFmul	SLU	eu,um,1; SLU	ev,vm,1		 1& \ut  M1. Unpack.\\
	SRU	eu,eu,49; SRU	ev,ev,49	 1&      		       
	XOR	s,um,vm; SRU	s,s,63		 1& $s \is s_u\times s_v$.
	ANDNH	um,#FFFF; ORH   um,#0001 	 1& ^{ORH+<ORH> (bitwise or with high wyde)}
	ANDNH	vm,#FFFF; ORH   vm,#0001 	 1& ^{ANDNH+<ANDNH> (bitwise and-not high wyde)}
%%%
%%%
%%%
	MULU	t,um,vl 			1& \ut  M2. Operate.\\ \lineref|4.2.3waste1|
	GET 	wl,:rH 				1& $\.wl. \is 2^{48}u_m\times 2^{64}v_l\times 2^{-64}$.
	MULU	t,ul,vm				1& \lineref|4.2.3waste2|
	GET     t,:rH; ADDU wl,wl,t		1& $\.wl. \is \.wl. + 2^{48}u_lv_m$.^{rH+rH (himult register)}^{Himult register}\lineref|4.2.3dfmnocarry|
	MULU	t,um,vm; GET wm,:rH		1& $\.wm. \is \lfloor 2^{32}u_m\times v_m\rfloor$.\lineref|4.2.3dfmhighmult|
	ADDU	wl,wl,t      			1& $\.wl. \is \.wl. +\.um.\times\.vm.\mod 2^{64}$.\lineref|4.2.3dfmwithcarry|
	CMPU	t,wl,t; ZSN carry,t,1		1& $\.carry. \is 1$ if $\.wl.+\.t.<\.t.$.
	ADDU	wm,wm,carry 			1& 
	SLU	wm,wm,16			1& $\.wm. \is 2^{16}\.wm.= 2^{16}\lfloor 2^{32}u_m\times v_m\rfloor $.
	SRU	carry,wl,64-16			1& 
	ADDU 	wm,wm,carry			1& 
	SLU	wl,wl,16			1& $\.wl. \is 2^{16}\.wl.$.\lineref|4.2.3addzero|
	ADD	e,eu,ev				1& 
	SET 	t,#3FFF; SUB e,e,t		1& $e\is e_u+e_v-q$.
%%%
	JMP	:DNormalize		    	1& \ut  M3. Normalize.\\\quad\slug
%%%off 
	   %28 instructions
