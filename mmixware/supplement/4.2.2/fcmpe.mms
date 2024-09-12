%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.2.2/fcmpe.mms
%	Author:	M.Ruckert
%	Title:	Exercise 17, Subroutine Fcmpe
%Assume that \MMIX/ needs to emulate its \.FCMPE. instruction in software.
%Write an \MMIX/ subroutine \.Fcmpe., that
%compares two nonzero normalized floating point numbers $u$ and $v$
%with respect to a positive normalized floating point number 
%$\epsilon$ stored in register \.rE..
%Under the conditions just stated, the subroutine should be equivalent 
%to the code sequence
%\.FCMPE \$0,\$0,\$1; POP 1,0., emulating the \.FCMPE. instruction.
	PREFIX	:Fcmpe:
u	IS	$0	1. parameter
v	IS	$1	2. parameter

eps	IS	$2	$\epsilon$
s	IS	$5	sign
carry	IS	$6	The shuttle between $f$ and $f_0$.

su	IS	$7
eu	IS	$8
fu	IS	$9
f0	IS	$10	The low 64 bits of $u$

ev	IS	$11
fv	IS	$12

d	IS	$13
x	IS	$14
t	IS	$15
%%%on
:Fcmpe	GET	eps,:rE					Get $\epsilon$.^{rE+rE (epsilon register)}
%%%off
	% SLU	ee,eps,1; SRU	ee,ee,53		Get exponent.
	% Optimization not needed
	% SET	t,1023; CMP t,ee,t
	% BNN t,Equal	If $e_\epsilon-q\ge0$ then $u\sim v$.
%%%on
	SET	su,u				Sign of $u$.
	XOR	s,u,v				Signs different?
	ANDNH	u,#8000; ANDNH v,#8000		Remove sign bits.
	CMPU	x,u,v; BNN	x,0F	        Compare $ \left\vertical u\right\vertical$ and $ \left\vertical v\right\vertical$.
	SET	t,u; SET u,v; SET v,t       	Swap $u$ with $v$.
%%%
0H	CSN	x,s,1				If signs are different,
	NEG	t,x				\quad $u$ is larger 
	CSN	x,su,t				\quad unless $u<0$.
	SRU	eu,u,52; SRU	ev,v,52		Get exponents.
	SETH	t,#FFF0			
	ANDN	fu,u,t; ANDN fv,v,t		Get fraction part.
	INCH	fu,#10; INCH fv,#10 		Add hidden bit.
%%%
	SUBU	d,eu,ev				Scale right.
	NEG	t,64,d
	CSN	t,t,0				Keep all low-order bits.	
	SLU	f0,fv,t			
	SRU	fv,fv,d
	SET	eu,1022				Divide by $2^{e_u-1022}$.
%%%
	BN	s,Add				Add if signs are different;
	NEGU	f0,f0; ZSNZ carry,f0,1		\quad else subtract.^{NEGU+<NEGU> (negate unsigned)}
	SUBU	fu,fu,fv; SUBU	fu,fu,carry 	$u \is \left\vertical u-v\right\vertical/2^{e_u-1022}$.
	OR	t,fu,f0; BZ t,Equal		Jump if $\left\vertical u-v\right\vertical=0$.
0H	SETH	t,#0010; AND t,fu,t		Normalized?
	BNZ	t,Compare
	SRU 	carry,f0,63
	SLU	fu,fu,1; OR fu,fu,carry		 Adjust left.
	SLU 	f0,f0,1
	SUB	eu,eu,1
	JMP	0B
Add	ADDU	fu,fu,fv	                $u \is \left\vertical u-v\right\vertical/2^{e_u-1022}$.
	SETH	t,#0020; CMP t,fu,t	Normalized?
	BN	t,Compare
	SLU 	carry,fu,63
	SRU	fu,fu,1; SRU f0,f0,1 	Adjust right.
	OR f0,f0,carry
	ADD	eu,eu,1
%%%
Compare ANDNH	fu,#FFF0		Remove hidden bit.
	SLU	eu,eu,52
	OR	u,eu,fu			Combine $e_u$ with $f_u$ and
	CMPU	t,u,eps			\quad compare to $\epsilon$.
	CSN	x,t,0			If $u<\epsilon$, then $u \sim v$.
	CSP	f0,t,1			If $u>\epsilon$, force $\.f0.\ne 0$.
Equal	CSZ	x,f0,0			If  $\.f0.= 0$, then $u \sim v$.
%%%	
 	SET	$0,x			Return \.x..
	POP	1,0			\slug
%%%off