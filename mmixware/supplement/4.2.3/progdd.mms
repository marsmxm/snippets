%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.2.3/progdd.mms
%	Author:	M.Ruckert
%	Title:	Program D, Double-precision Division
	PREFIX	:DFdiv
um	IS	$0	1. parameter
ul	IS	$1	1. parameter
vm	IS	$2	2. parameter
vl	IS	$3	2. parameter
wm	IS	$4	return value
wl	IS	$5	return value

s	IS	$6	$w$ unpacked
e	IS	$7
carry	IS	$8	The shuttle between $x_m$ and $x_l$.

r	IS	$9
pm	IS	$10
pl	IS	$11	
eu	IS	$12
ev	IS	$13

ql	IS	$14	$e_u - e_v$
t	IS	$15

%%%on
:DFdiv	SLU	eu,um,1; SLU	ev,vm,1			1& \ut  D1. Unpack.\\ 	
	SRU	eu,eu,49; SRU	ev,ev,49		1& 	       
	XOR	s,um,vm; SRU	s,s,63		        1& $s_w \is s_u\cdot s_v$.
	ANDNH	um,#FFFF; ORH   um,#0001		1&  ^{ORH+<ORH> (bitwise or with high wyde)}	
	SLU	vm,vm,15; ORH 	vm,#8000		1& $v_m\is v_m2^{15}$.	
        SRU	carry,vl,64-15				1& 			
	ADDU 	vm,vm,carry				1& 	
	SLU	vl,vl,15				1& $(v_m,v_l)\is (v_m,v_l)2^{15}$.	
	SUB	e,eu,ev; INCL e,#3FFF-1			1& $e\is e_u-e_v+q-1$.\lineref|4.2.3adjuste|
%%%			
	PUT	:rD,um					1& \ut  D2. Operate.\\
	DIVU 	wm,ul,vm 		  		1& $ \.wm.\is \lfloor 2^{48+1}(u_m+\epsilon\, u_l)/v_m\rfloor$.\lineref|4.2.3divu|
	GET 	r,:rR					1& Get remainder $r$.
	PUT	:rD,r; SET t,0				1& 
	DIVU	wl,t,vm					1& $\.wl.\is 2^{64}r/v_m$.
	MULU	pl,wm,vl; GET	pm,:rH			1& $(p_m,p_l) \is w_m\times v_l$.	
	PUT	:rD,pm					1& 
	DIVU	ql,pl,vm				1& $q_l\is (p_m+\epsilon\,p_l)/v_m$.	
	CMPU	t,wl,ql; ZSN carry,t,1		        1& $\.carry.\is [w_l<q_l]$.
	SUBU	wl,wl,ql; SUBU	wm,wm,carry		1& $w\is w-\epsilon\,q_l$.
%%%
	JMP	:DNormalize				1& \ut  M3. Normalize.\\\quad\slug
%%%off
