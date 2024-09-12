%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.2.3/ex6b.mms
%	Author:	M.Ruckert
%	Title:	Exercise 6, Double to single-precision floating point conversion
%%%

	  	PREFIX :ToSingle:
f		IS	$0	Parameter
fl		IS	$1
s		IS	$2	Local variables
e		IS	$3
carry		IS	$5
w		IS	$6
t		IS	$7
%%%on
:ToSingle      SRU	s,f,63			Get sign bit.
	       SLU	e,f,1; SRU e,e,49	Get exponent.
	       SET	t,#3FFF-#3FF-4		
	       SUBU	e,e,t			Adjust exponent.
	       ANDNH	f,#FFFF		Remove sign and exponent.^{ANDNH+<ANDNH> (bitwise and-not high wyde)}
	       INCH	f,1			Add hidden bit.
	       JMP	:Normalize		Normalize, round, and exit.\quad\slug
%%%off

