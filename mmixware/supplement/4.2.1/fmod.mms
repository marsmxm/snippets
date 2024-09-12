%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.2.1/fmod.mms
%	Author:	M.Ruckert
%	Title:	Exercise 15, Subroutine Fmod
	LOC	#100
	PREFIX	:Fmod:
u	IS	$0	1. parameter
s	IS	$1	$u$ unpacked
e	IS	$2
f	IS	$3
fl	IS	$4
carry	IS	$5	for rounding
w	IS	$6
t	IS	$7
%%%on
:Fmod	ZSN	s,u,1			 %\ut  1. Unpack.\\ Set sign. 
	ANDNH	u,#8000			 Remove sign bit. 
	SRU 	e,u,52			 Get exponent. 
       	SETH	t,#FFF0; ANDN	f,u,t    Get fraction part and
	INCH	f,#10	   		 \quad add hidden bit.  
	SET	fl,0   	   		 $u=\pm (f,f_l)2^{e-q}/2^{52}$.
	SET	t,1023; SUB e,e,t	 %\foolit{q}\ut  2. Subtract \setfool.\\ 
	BN	e,0F	      		 Branch if $u$ has no integer part.
	ADD	t,e,12; SLU f,f,t	 %\ut  3. Remove integer part.\\
	SRU	f,f,12
	SET	e,0			
0H	BZ	f,6F			 Branch if $u$ has no fraction part.
	BZ	s,5F			 Branch if $u$ is nonnegative.
	ADD	t,e,64; SLU fl,f,t	 \ut  4. Complement fraction part.\\
	NEG	t,e; SRU f,f,t	 	 $(f,f_l)\is (f,0)/2^e$.
	SET	e,0    	   		 $e \is 0$.
	NEGU	fl,fl			 ^{NEGU+<NEGU> (negate unsigned)}
	ZSNZ	carry,fl,1
	ADDU 	f,f,carry
	SETH	t,#10; SUBU	f,t,f	 $(f,f_l)\is 1 - (f,f_l)$.
	SET	s,0			 $(f,f_l)>0$.
5H	INCL	e,1023			 \foolit{q}\ut  5. Add \setfool.\\
	OR	t,f,fl; BNZ t,:Normalize  \ut  6. Normalize if not zero.\\
6H	POP	0,0	      		 Else return 0.\quad\slug
%%%off
