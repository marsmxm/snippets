%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.2.1/progd.mms
%	Author:	M.Ruckert
%	Title:	Program M, Floating Point Division
	PREFIX	:Div:
u	IS	$0	$u$
w	IS	$0	$w$	needed for normalize

v	IS	$1	$v$

s	IS	$2	$s$
e	IS	$3      $e$
f	IS	$4	$f$
%%%The low 64 bits of $f$
fl	IS	$5	$f_l$ 
carry	IS	$13	The shuttle between $f$ and $f_l$.

eu	IS	$7	$e_u$
fu	IS	$8	$f_u$

ev	IS	$10	$e_v$
fv	IS	$11	$f_v$

d	IS	$12	$e_u - e_v$
t	IS	$14	$t$

%%%on
:Fdiv	SLU	eu,u,1;	SRU	eu,eu,53	1 & \ut  M1. Unpack.\\
	SLU	ev,v,1; SRU	ev,ev,53	1 & 
	SETH	t,#FFF0				1 & Get sign and exponent mask.
	ANDN	fu,u,t; ANDN fv,v,t 		1 & Remove sign and exponent bits.
	INCH	fu,#10; INCH fv,#10    		1 & Add hidden bit.
	XOR	s,u,v; SRU s,s,63		1 & $s\is s_u\times s_v$.
%%%
	SLU	fv,fv,11			1 & \ut  M2. Operate.\\ $f_v \is 2^{11}f_v$.
%%%
	PUT	:rD,fu; SET t,0			1 & \lineref|4.2.1ddstart|^{rD+rD (dividend register)}
	DIVU f,t,fv				1 & $(f,f_l)\is 2^{52+64}f_u/(2^{52+11}f_v)=2^{53}f_u/f_v$.
	GET 	t,:rR; PUT :rD,t		1 & ^{rR+rR (remainder register)}^{Remainder register}	
	SET t,0; DIVU fl,t,fv			1 & \lineref|4.2.1ddstop|
	SUB	e,eu,ev				1 & 
	INCL 	e,1023-1			1 & $e\is e_u-e_v+q-1$.
%%%
	JMP	:Normalize			1 & \ut  M3. Normalize.\\\quad\slug
%%%off