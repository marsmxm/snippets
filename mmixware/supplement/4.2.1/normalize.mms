%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.2.1/normalize.mms
%	Author:	M.Ruckert
%	Title:	Program A, Normalization
%%%on
:Normalize  OR	t,f,fl; BZ t,:Zero	1\bg{0} & Assume $u+v\ne 0$.		
	    SRU	t,f,53	 		1 &	\ut  N1. Test $f$.\\
	   BP	t,N4	 	 	1\bg{R} &	If $f\ge 2$, scale right.
%%%
N2	   SRU	t,f,52; BP t,N5	N+1-R\bg{1-R} &	\ut  N2. Is $f$ normalized?\\
%%%
	   SRU	carry,fl,63		N &	\ut  N3. Scale left.\\
	   SLU	fl,fl,1			N &
	   SLU	f,f,1			N &
	   ADDU f,f,carry		N &
	   SUB	e,e,1			N &
	   JMP N2			N &
%%%
N4	   SLU	carry,f,63		R+O &	\ut  N4. Scale right.\\ 
	   SRU	f,f,1			R+O &
	   SRU	fl,fl,1			R+O &
	   ADDU fl,fl,carry		R+O &
	   ADD	e,e,1			R+O &
%%%
N5	   SETH	t,#8000			1+O &	\ut  N5. Round.\\
	   CMPU	t,fl,t			1+O &	Compare $f_l$ to ${1\over 2}$.
	   CSOD	carry,f,1		1+O &  	$f$ is odd. Round up if $f_l \ge {1\over 2}$.^{CSOD+<CSOD> (conditional set if odd)}
	   CSEV	carry,f,t		1+O &	$f$ is even. Round up if $f_l > {1\over 2}$.^{CSEV+<CSEV> (conditional set if even)}
	   ZSNN	carry,t,carry		1+O & 	Round down if $f_l < {1\over 2}$.
	   ADDU	f,f,carry		1+O &
	   SET	fl,0			1+O &
	   SRU	t,f,53; BP t,N4		1+O\bg{O} &	Rounding overflow.
%%%
	   SET	t,#7FE; CMP t,e,t  	1 &	\ut  N6. Check $e$.\\
	   BP	t,:Error		1\bg{V} &	Overflow.
	   BNP	e,:Error		1-V\bg{W} &	Underflow.
%%%
	   SLU	w,s,63			1-V-W &	\ut  N7. Pack.\\
	   SLU	t,e,52; OR w,w,t	1-V-W &
	   ANDNH f,#FFF0		1-V-W &	Remove hidden bit.^{ANDNH+<ANDNH> (bitwise and-not high wyde)}
	   OR	$0,w,f			1-V-W &
%%%
	   POP	1,0			  &	Return $w$.
:Zero	   POP	0,0			  &	Return zero.\quad\slug
%%%off
