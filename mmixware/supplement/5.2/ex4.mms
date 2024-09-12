%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2/ex4.mms
%	Author:	M.Ruckert
%	Title:	Exercise 4, Finish sorting
	PREFIX :Finish:



r	IS	$0	
count	IS	$1
s	IS	$2	
n	IS	$3	
i	IS	$3	reusing register for n
ri	IS	$4	
ci	IS	$5	
t	IS	$6
	
%%%on
:Finish	SL	i,n,3		1 &
	JMP	0F		1 &
1H	LDO	ri,r,i		N &	
	LDO	ci,count,i	N &
	STO	ri,s,ci		N &	Counts are already scaled.
0H	SUB	i,i,8		N+1 &
	PBNN	i,1B		N+1\bg{1} &\slug
%%%rt 5.2ex4.rt & (5N+6)\upsilon +3N\mu
%%%off
	POP	0,0

	PREFIX	:
%%%on