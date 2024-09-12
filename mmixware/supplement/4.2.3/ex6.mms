%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.2.3/ex6.mms
%	Author:	M.Ruckert
%	Title:	Exercise 6, Single to double-precision floating point conversion
	  	PREFIX :ToDouble:
x	  	IS	$0	Parameter
xl	  	IS	$2
s	  	IS	$3	Local variables
exm	  	IS	$4
%%%on
:ToDouble   	BZ	x,:Zero
		SRU	s,x,63;	SLU s,s,63	Extract sign.
	   	SLU	exm,x,1; SRU exm,exm,5  Position $e_x$ and $x_m$.
	   	INCH	exm,#3FFF-#3FF	     	Adjust exponent.^{INCH+<INCH> (increase by high wyde)}
	   	SLU	$0,x,64-(52-48)      	Extract $x_l$.	
	  	OR 	$1,exm,s		Add sign bit.	
	   	POP	2,0			Return. \quad\slug
%%%off
