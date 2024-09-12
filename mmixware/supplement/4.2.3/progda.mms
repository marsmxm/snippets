%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.2.3/progda.mms
%	Author:	M.Ruckert
%	Title:	Program A, Double-precision Addition
	PREFIX	:DFadd:

um	IS	$0	1. parameter
ul	IS	$1	1. parameter
vm	IS	$2	2. parameter
vl	IS	$3	2. parameter

wm	IS	$4	return value
wl	IS	$5	return value
s	IS	$6	$w$ unpacked
e	IS	$7
carry	IS	$8	The shuttle between $x_m$ and $x_l$.
su	IS	$9	$u$ unpacked
eu	IS	$10
sv	IS	$11	$v$ unpacked
ev	IS	$12
d	IS	$13	$e_u - e_v$
t	IS	$14

%%%on
:DFsub	SETH	t,#8000; XOR vm,vm,t		 & Change sign of operand.
:DFadd	SLU	eu,um,1; SLU ev,vm,1		1& Remove sign bit.
	CMPU	t,eu,ev				1& \ut  A2. Assume\/\hair\\   
	BP	t,A1			        1\bg{A}& \hfill\ut \hair$e_u$ dominates $e_v$.\\    
 	PBN	t,0F				1-A\bg{0}&
	CMPU t,ul,vl; BNN t,A1			 & If $ (e_u, u_m, u_l) < (e_v, v_m,v_l) $,
0H	SET	t,um; SET um,vm; SET vm,t       1-A &\qquad swap $u$ with $v$
	SET	t,ul; SET ul,vl; SET vl,t 	1-A &\qquad and
	SLU	eu,um,1; SLU ev,vm,1	        1-A &\qquad remove sign bit again.
%%%
A1	SRU	eu,eu,49; SRU	ev,ev,49	1& \ut  A1. Unpack.\\ 
	SRU	su,um,63; SRU	sv,vm,63	1& Get sign bit.
	ANDNH	um,#FFFF; ANDNH	vm,#FFFF	1& Remove $s$ and $e$ bits.\lineref|4.2.3umclear|^{ANDNH+<ANDNH> (bitwise and-not high wyde)}
	ORH	um,#0001; ORH 	vm,#0001	1& Add hidden bit.^{ORH+<ORH> (bitwise or with high wyde)}\lineref|4.2.3aunpack|
%%%
	SET	e,eu; SET s,su			1& \ut  A3. Set $e_w \is e_u$.\\ 
%%%
	SUB	d,eu,ev				1& \ut  A4. Test $e_u-e_v$.\\ 
	CMP	t,d,113+2; PBN	t,A5		1\bg{0}&  $e_u-e_v \ge p+2$ ?
	SET	wm,um; SET wl,ul  		 &$w \is u$.
	JMP	:DNormalize			 &
%%%
A5    	CMP	t,d,64; PBN t,0F		1\bg{0} & \ut  A5. Scale right.\\ \lineref|4.2.3atruncate|
	SET	vl,vm; SET  vm,0		 & Scale right by 64 bits.
	SUB d,d,64    				 & \lineref|4.2.3atruncateend|
0H	NEG	t,64,d				1& \lineref|4.2.3shift|
	SRU	vl,vl,d				1& 
	SLU carry,vm,t; OR vl,vl,carry		1& Shift $(v_m,v_l)$ right by
	SRU vm,vm,d				1& \qquad $e_u-e_v$ places.
%%%
	CMP	t,su,sv; BNZ	t,0F		1\bg{B}& Signs $s_u$ and $s_v$ differ.
	ADDU	wl,ul,vl			1-B & \ut  A6. Add.\\
	CMPU	t,wl,ul; ZSN carry,t,1		1-B & 
	ADDU	wm,um,vm     			1-B & 
	ADDU	wm,wm,carry			1-B & 
	JMP	:DNormalize			1-B & 
%%%
0H	SUBU	wl,ul,vl			B & \ut  A6. Subtract.\\ \lineref|4.2.3ex5subtract|
	CMPU 	t,wl,ul; ZSP carry,t,1		B & 
	SUBU	wm,um,vm			B & \lineref|4.2.3asubu|
	SUBU 	wm,wm,carry 			B & 
%%%off						  & \slug

	   