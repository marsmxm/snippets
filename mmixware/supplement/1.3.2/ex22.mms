%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	1.3.2/ex22.mms
%	Author:	M.Ruckert
%	Title:	Exercise 22, Josephus problem

	PREFIX :Josephus:

n	IS     $0	Number of men in the circle
m	IS     $1	Execution distance
x	IS     $2	Array of $n$ bytes to hold the result
i	IS     $3	Counter
e	IS     $4	Execution count
l	IS     $5	Lucky man
d	IS     $6	Doomed man
p	IS     $7	Pointer to man
t	IS     $8	
%%%on
:Josephus SET	i,n	1	&
	  SET	t,0	1	&
	  JMP	1F	1	&
0H	  STBU	t,x,i	N	&Set each cell to the
	  SET	t,i	N	&\quad number of the next man
1H	  SUB	i,i,1	N+1	&\quad in the sequence.
	  PBNN	i,0B 	N+1\bg{1} &
%%%
	  SET	e,1	1	&Set execution count.
	  SET	p,0	1	&Start with the first man.
0H	  SUB	i,m,3	N-1	&Count around the circle.
1H	  LDBU	p,x,p	(M-3)(N-1) &
	  SUB	i,i,1	(M-3)(N-1) &
	  PBP	i,1B	(M-3)(N-1)\bg{N-1} &
	  LDBU  l,x,p   N-1     &lucky man
	  LDBU	d,x,l	N-1	&doomed man
	  LDBU	p,x,d	N-1	&next man
	  STBU	p,x,l	N-1	&Take man from circle.
	  STBU	e,x,d	N-1	&Store execution count.
	  ADD	e,e,1	N-1	&Increment execution count.
	  CMP	t,e,n	N-1	&How many left?
	  PBN	t,0B	N-1\bg{1} &
	  STBU	e,x,l	1	&One man left; he is clobbered too.
	  POP	0,0		&\slug
%%%rt 1.3.2ex22.rt & (3(N-1)(M+2) +16)\upsilon+((N-1)(M+3)+2)\mu
%%%off