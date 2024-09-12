%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.2.1/proga.mms
%	Author:	M.Ruckert
%	Title:	Program A, Addition and Subtraction
	PREFIX	:Add:
w	IS	$0	$w$
u	IS	$0	$u$
v	IS	$1	$v$

s	IS	$2	$s$
e	IS	$3      $e$
f	IS	$4	$f$
fl	IS	$5	$f_l$
carry	IS	$13	The shuttle between $f$ and $f_l$.

su	IS	$6	$s_u$
eu	IS	$7	$e_u$
fu	IS	$8	$f_u$

sv	IS	$9	$s_v$
ev	IS	$10	$e_v$
fv	IS	$11	$f_v$

d	IS	$12	$e_u - e_v$

t	IS	$14

%%%on
:Fsub	SETH	t,#8000; XOR v,v,t		 & Change sign of operand.
:Fadd	SLU	eu,u,1;	SLU	ev,v,1		1& Remove sign bit.
	CMPU	t,eu,ev				1& \ut  A2. Assume $e_u$ dominates $e_v$.\\       
	BNN	t,A1			        1\bg{A}& Jump if $ (e_u, f_u) \ge (e_v, f_v) $;
	SET	t,u; SET u,v; SET v,t       	1-A& \quad else swap $u$ with $v$
	SLU	eu,u,1;	SLU	ev,v,1	        1-A& \quad and remove sign bits again.
%%%
A1	SRU	eu,eu,53; SRU	ev,ev,53	1& \ut  A1. Unpack.\\ 
        SETH	t,#FFF0				1& Get sign and exponent mask.
	ANDN	fu,u,t; ANDN fv,v,t 		1& Remove sign and exponent.
	INCH	fu,#10;	INCH	fv,#10		1& Add hidden bit.^{INCH+<INCH> (increase by high wyde)}
	SRU	su,u,63; SRU	sv,v,63		1& Get sign bit.
%%%
	SET	e,eu; SET s,su			1& \ut  A3. Set $e_w \is e_u$.\\ 
%%%     Step A4 can be omitted
	SUB	d,eu,ev				1& Step A4 unnecessary.
%%%	CMP	t,d,53+2; PBN	t,A5		 & $e_u-e_v \ge p+2$?
%%%	SET	f,fu; SET fl,0  		 & $(f,f_l) \is f_u$.
%%%	JMP	A7				 &
%%%
A5    	NEG	t,64,d				1& \ut  A5. Scale right.\\
	SLU	fl,fv,t	     	       		1& Shift $(f_v,f_l)$ to the right 
	SRU	fv,fv,d	      	       		1& \qquad $e_u-e_v$ places.
%%%
	CMP	t,su,sv; BNZ	t,0F		1\bg{B}& Signs $s_u$ and $s_v$ differ.
	ADDU	f,fu,fv	                	1-B& \ut  A6. Add.\\
	JMP	:Normalize			1-B& 
0H	NEGU	fl,fl; ZSNZ carry,fl,1		B& \ut  A6. Subtract.\\^{NEGU+<NEGU> (negate unsigned)}
	SUBU	f,fu,fv	    			B& 
	SUBU	f,f,carry 			B& 
%%%A7	IS	@	 	 \ut  A7. Normalize.\\
%%%off				 \slug