%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.6.3/xnmodw.mms
%	Author:	M.Ruckert
%	Title:	Exercise 2, Evaluation of powers

x	IS	$0	&Parameter
n	IS	$1	&
y	IS	$2	&Local variable
z	IS	$0	&Alias for $x$
&
%%%on
A1	SET	y,1	 1		&\ut  A1. Initialize.\\
	JMP	0F	 1		&
%%\mmsskip
A2	SRU	n,n,1	 L+1-K	&\ut  A2. Halve $N$.\\ $N$ even.
A5	MULU	z,z,z	 L   	&\ut  A5. Square $Z$.\\
0H	PBEV	n,A2	 L +1\bg{K} 	&\ut  A2. Halve $N$.\\  $N$ odd.
	SRU	n,n,1	 K 	    	&$N\is\lfloor N/2\rfloor$.
	MULU	y,z,y	 K 	&\ut  A3. Multiply $Y$ by $Z$.\\
	PBNZ	n,A5	 K\bg{1} 	&\ut  A4. $N=0$?\\
	SET	$0,y	 1 		& Return $Y$.
	POP	1,0	 		&\slug
%%%rt 4.6.3xnmodw.rt & (12L+ 13K+7)\upsilon
%%%off