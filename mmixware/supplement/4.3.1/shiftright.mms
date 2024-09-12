%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.3.1/shiftright.mms	
%	Author:	M.Ruckert
%	Title:	Exercise 26, subroutine ShiftRight
	PREFIX	:ShiftRight:
	% Shift left array \.x. of \.n. octabytes by \.p. bit. Return last carry.
x	IS	$0	Parameter
n	IS	$1
p	IS	$2
i	IS	n	shares register with \.n.
q	IS	$3	$64-p$
k	IS	$4	Return value
xi	IS	$5
t	IS	$6
%%%on		
:ShiftRight	NEG	q,64,p	      		$q \is 64-p$.
	SET	k,0				$k\is 0$.
	SLU 	i,n,3				$i\is n$.
	JMP	1F      		
0H	LDOU 	xi,x,i 	   	      	    	Load $x_i$.
	SRU	t,xi,p; OR t,t,k   		Shift and add carry.
	STOU	t,x,i	    		   	Store $x_i$.
	SLU	k,xi,q		    		New carry.
	SUB	i,i,8				$i\is i-1$.
1H	PBNN	i,0B				Loop on $i$.
	SET	$0,k				Return carry.
	POP	1,0				\slug
%%%off