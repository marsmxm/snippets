%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	3.2.1.1/ex2.mms
%	Author:	M.Ruckert
%	Title:	Exercise 2
%%%on
:Random	MULU x,x,a    	$ X \is aX \mod w$.
	ADDU  x,x,c    	$ X \is (X + c ) \mod w$.
	SET  $0,x
	POP  1,0	\slug
%%%off
