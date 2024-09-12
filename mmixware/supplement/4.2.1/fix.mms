%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.2.1/fix.mms
%	Author:	M.Ruckert
%	Title:	Exercise 14, Floating point to integer conversion
%%
	PREFIX	:Fix:
u	IS	$0	1. parameter and return value
s	IS	$1	$u$ unpacked
e	IS	$2
f	IS	$3
carry	IS	$4	for rounding
fl	IS	$5
t	IS	$6
%%%on
:Fix	ZSN	s,u,1			 \ut Unpack.\\ Record sign.
	ANDNH	u,#8000			 Remove sign bit.^{ANDNH+<ANDNH> (bitwise and-not high wyde)}
	SRU	e,u,52			 Get exponent.
	SLU	u,u,11			 Get fraction part
	ORH	u,#8000		 	 \quad and add hidden bit.^{ORH+<ORH> (bitwise or with high wyde)}
	SET	t,1023+63; SUB e,e,t     $e\is e-q-63$. Now $u = \.u.\times2^e$.
	BP	e,:Error		 Overflow.
	BZ	e,Sign
%%%	
	   NEG	e,e			\ut  Round.\\ Set $e\is -e$.
	   NEG	t,64,e			
	   SLU	f,u,t			$f\is \hbox{the fraction part of $\.u.\times2^e$}$.
	   SRU 	u,u,e			$\.u.\is \lfloor \.u.\times2^e\rfloor$.
	   SETH	t,#8000; CMPU	t,f,t	Compare $f$ to $0.5$.	
	   CSOD	carry,u,1  		$u$ is odd. Round up if $f \ge {1\over 2}$.^{CSOD+<CSOD> (conditional set if odd)}
	   CSEV	carry,u,t		$u$ is even. Round up if $f > {1\over 2}$.^{CSEV+<CSEV> (conditional set if even)}
	   ZSNN	carry,t,carry 		Round down if $f < {1\over 2}$.
	   ADDU	u,u,carry
%%%					
Sign	   BNZ	s,Negative		Attach sign.	
	   BN	u,:Error		Overflow.
	   POP	1,0			Return \.u..
Negative	   NEG     u,u
	   BNN	u,:Error		Overflow.
%%\noalign{\nobreak}
	   POP	1,0			Return \.u..\quad\slug
%%%off
