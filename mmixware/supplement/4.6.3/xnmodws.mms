%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.6.3/xnmodws.mms
%	Author:	M.Ruckert
%	Title:	Exercise 2, serial program
%%	serial exponentiation
%%%
x	IS	$0	&Parameter
n	IS	$1
y	IS	$2	&Local variable
%%%on
A1	SET	y,x	 1	 &
	JMP	1F	 1	 &
0H	MUL	y,y,x	 N-1     &
1H	SUB	n,n,1	 N       &
	PBP	n,0B	 N\bg{1} &
	SET	$0,y	 1	 &
	POP	1,0	 	 &\quad\slug
%%%rt 4.6.3xnmodws.rt & (12N- 5)\upsilon
%%%off