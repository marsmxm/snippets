%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	3.2.2/bits.mms
%	Author:	M.Ruckert
%	Title:	Program (10)
t	IS	$0
%%%on
	ZSN	t,x,a	Adjust by \.a. if the high bit of \.x. is 1, else by zero.
	SLU	x,x,1	Shift left one bit.
	XOR	x,x,t	Apply the adjustment with ``exclusive or.''\quad\slug
%%%off