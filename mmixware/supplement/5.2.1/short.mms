%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.1/short.mms
%	Author:	M.Ruckert
%	Title:	Exercise 3, Shortest MMIX sorting program

key	IS	$0	& Parameter
n	IS	$1	
	
i	IS	$2	 &Local variables.
r	IS	$3
s	IS	$4
t	IS	$5
%%%on
2H	LDB	r,key,i		B & $r\is K_i$.
	SUB	i,i,1		B & Decrement $i$.
	LDB	s,key,i		B & $s\is K_{i-1}$.
	CMP	t,s,r		B &
	PBNP	t,1F		B\bg{A} & Continue if $K_{i-1} \le K_i$;
	STB	r,key,i		A & \quad else swap $K_i$
	ADD	i,i,1		A & \quad with $K_{i-1}$\lineref|5.1.2-short-add|
	STB	s,key,i		A & \quad and start from the beginning.\lineref|5.1.2-short-stb|
:Sort	SUB	i,n,1		A+1 & Initialize $i\is n-1$.\lineref|5.1.2-short-scale|
1H	PBP	i,2B		B+1\bg{1} & Loop while $i> 0$.
	POP	0,0		    &\slug
%%%off