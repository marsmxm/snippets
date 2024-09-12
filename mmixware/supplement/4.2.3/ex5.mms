%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.2.3/ex5.mms
%	Author:	M. Ruckert
%	Title:	Exercise 5, Double-precision Addition 

	PREFIX	:DFadd:
%%tex	um	$u_m$
um	IS	$0	1. parameter
%%tex	ul	$u_l$
ul	IS	$1	1. parameter
%%tex	vm	$v_m$
vm	IS	$2	2. parameter
%%tex	vl	$v_l$
vl	IS	$3	2. parameter
%%tex	wm	$w_m$
wm	IS	$4	return value
%%tex	wl	$w_l$
wl	IS	$5	return value

%%tex	s	$s$
s	IS	$6	$w$ unpacked
%%tex	e	$e$
e	IS	$7
carry	IS	$8	The shuttle between $x_m$ and $x_l$.

%%tex	su	$s_u$
su	IS	$9	$u$ unpacked
%%tex	eu	$e_u$
eu	IS	$10

%%tex	sv	$s_v$
sv	IS	$11	$v$ unpacked
%%tex	ev	$e_v$
ev	IS	$12

%%tex	d	$d$
d	IS	$13	$e_u - e_v$
%%tex	t	$t$
vll	IS	$14
t	IS	$15

%%%
:DFsub	SETH	t,#8000; XOR vm,vm,t	Change sign of operand.
:DFadd	SLU	eu,um,1; SLU ev,vm,1		Remove sign bit.
	CMPU	t,eu,ev			\ut  A2. Assume  $e_u$ dominates $e_v$.\\	       
	BP	t,A1			       
 	BN	t,0F
	CMPU t,ul,vl; BNN t,A1			If $ (e_u, u_m, u_l) < (e_v, v_m,v_l) $
0H	SET	t,um; SET um,vm; SET vm,t       \qquad swap $u$ with $v$
	SET	t,ul; SET ul,vl; SET vl,t 	\qquad and
	SLU	eu,um,1; SLU ev,vm,1	        \qquad remove sign bit again.
%%%
A1	SRU	eu,eu,49; SRU	ev,ev,49	\ut  A1.~Unpack.\\ 
	SRU	su,um,63; SRU	sv,vm,63	Get sign bit.
	ANDNH	um,#FFFF; ANDNH	vm,#FFFF	Remove $s$ and $e$ bits.\lineref|4.2.3umclear|
	ORH	um,#0001; ORH 	vm,#0001	Add hidden bit.	\lineref|4.2.3aunpack|
%%%
	SET	e,eu; SET s,su		\ut  A3.~Set $e_w \is e_u$.\\ \lineref|4.2.3ex4init|
%%%on    ex5init.tex
	SET	vll,0
%%%off
%%%
	SUB	d,eu,ev		\ut  A4.~Test $e_u-e_v$.\\ 
	CMP	t,d,113+2; PBN	t,A5		 $e_u-e_v \ge p+2$ ?
	SET	wm,um; SET wl,ul  		 $w \is u$.
	JMP	:DNormalize		
%%%
%%%on	ex5truncate.tex
A5    	CMP	t,d,64; PBN t,0F		\ut  A5.~Scale right.\\ 
	SET	vll,vl; SET vl,vm; SET  vm,0	Shift right by 64 bits.
	SUB d,d,64    				
0H    	CMP	t,d,64; PBN t,0F		
	SET	vll,vl; SET vl,vm; SET  vm,0	Shift right by 64 bits.
	SUB d,d,64    				
%%%off
0H	NEG	t,64,d			
%%%on    ex5shift.tex
	SRU	vll,vll,d; SLU 	carry,vl,t; OR vll,vll,carry
%%%off	
	SRU	vl,vl,d
	SLU carry,vm,t; OR vl,vl,carry	Shift $(v_m,v_l)$ right by
	SRU vm,vm,d			\qquad $e_u-e_v$ places.
%%%
	CMP	t,su,sv; BNZ	t,0F		Signs $s_u$ and $s_v$ differ.
	ADDU	wl,ul,vl			\ut  A6.~Add.\\
	CMPU	t,wl,ul; ZSN carry,t,1
	ADDU	wm,um,vm
	ADDU	wm,wm,carry	
	JMP	:DNormalize
%%%
0H	SUBU	wl,ul,vl 	\ut  A6.~Subtract.\\ 
%%%on    ex5subtract.tex
	ZSNZ	carry,vll,1; SUBU wl,wl,carry; NEGU vll,vll
%%%off
	CMPU 	t,wl,ul; ZSP carry,t,1
	SUBU	wm,um,vm			\lineref|4.2.3asubu|
	SUBU 	wm,wm,carry 
%%

%%%	Taken from dnormalize.mms and modified

	
:DNormalize  SRU	t,wm,49			\foolit{f}\ut  N1.~Test \setxfool.\\
	   BOD  t,N4	 			If $w\ge 2$, scale right.\lineref|4.2.3scaleright|
	   OR	t,wm,wl; BZ t,:Zero		\lineref|4.2.3zero|
%%%
N2	   SRU	t,wm,48; PBOD	t,6F		\ut  N2. Is $w$ normalized?\\	
%%%
%%%on	   ex5scaleleft.tex
	   ZSN	t,vll,1; SLU vll,vll,1		\ut  N3. Scale left.\\ 
	   ZSN	carry,wl,1; SLU	wl,wl,1; ADDU wl,wl,t
%%%off
	   SLU	wm,wm,1
	   ADDU wm,wm,carry
	   SUB	e,e,1
	   JMP N2
%%%
%%%on	   ex5scaleright.tex
N4	   SLU	carry,wl,63; SRU vll,vll,1 	\ut  N4. Scale right.\\ 
	   ADDU vll,vll,carry; SLU carry,wm,63
%%%off
	   SRU	wl,wl,1
	   ADDU wl,wl,carry
	   SRU	wm,wm,1
	   ADD	e,e,1
%%%on	   ex5round.tex
6H	   SETH	t,#8000				\ut  N5.~Round.\\
	   CMPU	t,vll,t				Compare $f_l$ to ${1\over 2}$.
	   CSOD	carry,wl,1  			$f$ is odd. Round up if $f_l \ge {1\over 2}$.
	   CSEV	carry,wl,t			$f$ is even. Round up if $f_l > {1\over 2}$.
	   ZSNN	carry,t,carry 			Round down if $f_l < {1\over 2}$.
	   ADDU	wl,wl,carry
	   ZSZ  carry,wl,carry
	   ADDU	wm,wm,carry
	   SET	vll,0
	   SRU	t,wm,49; BP t,N4			Rounding overflow.
%%%off
%%%
6H	   SET	t,#7FFE; CMP	t,e,t   	\ut  N6. Check $e$.\\
	   BP	t,:Error				Overflow.
	   BNP	e,:Error				Underflow.
%%%
	   SLU	s,s,63				\ut  N7.~Pack.\\	
	   SLU	e,e,48;
	   ANDNH wm,#FFFF			Remove hidden bit.\lineref|4.2.3wmclear|
	   OR 	 wm,wm,s; OR wm,wm,e
%%%
	   SET	$0,wl
	   SET	$1,wm
	   POP	2,0				Return $w$.
:Zero	   POP	0,0				Return zero. \quad\slug
%%%off

	   
	   