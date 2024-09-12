%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.6.4/fifth.mms
%	Author:	M. Ruckert
%	Title:	Exercise 20, Evaluation of a polynomial
%%%on
	FADD	y,x,a0		$y\is x+\alpha_0$.
	FMUL	y,y,y		$y\is (x+\alpha_0)^2$.^{FMUL+<FMUL> (floating multiply)}
	FADD	u,y,a1		$u\is (y+\alpha_1)$.	
	FMUL	u,u,y		$u\is (y+\alpha_1)y$.
	FADD	u,u,a2		$u\is (y+\alpha_1)y+\alpha_2$.
	FADD	t,x,a3		$t\is x+\alpha_3$.
	FMUL	u,u,t		$u\is ((y+\alpha_1)y+\alpha_2)(x+\alpha_3)$.
	FADD	u,u,a4		$u\is ((y+\alpha_1)y+\alpha_2)(x+\alpha_3)+\alpha_4$.
	FMUL	u,u,a5		$u\is \bigl(((y+\alpha_1)y+\alpha_2)(x+\alpha_3)+\alpha_4\bigr)\alpha_5$.\quad\slug
%%%off