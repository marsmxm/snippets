%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.3.1/shiftleft.mms	
%	Author:	M. Ruckert	
%	Title:	Exercise 25, subroutine ShiftLeft

%%%on
	PREFIX	:ShiftLeft:
%%%	% Shift left array \.X. of \.n. octabytes by \.p. bit. Return last \.k..
%%\mmsskip		
x	IS	$0	\.LOC($x_0$). 
n	IS	$1	$n$\kern 4em $\smash{\left.\vcenter to 24pt{\vfil}\right\}}$ Parameter	
p	IS	$2	$p$ 
i	IS	n	$i$ shares a register with $n$.
q	IS	$3	$64-p$
k	IS	$4	Carry
xi	IS	$5	$x_i$
t	IS	$6	Temporary variable
%%\mmsskip		
:ShiftLeft	NEG	q,64,p				$q \is 64-p$.
		SET	k,0				$k\is 0$.
		SLU i,n,3; ADDU x,x,i; NEG i,i		$i\is 0$.	      		
0H		LDOU 	xi,x,i 	   	      	    	Load $x_i$.
		SLU	t,xi,p; OR t,t,k   	    	Shift and add carry.
		STOU	t,x,i	    		    	Store $x_i$.
		SRU	k,xi,q		    		New carry.
		ADD	i,i,8			    	$i\is i+1$.
		PBN	i,0B			   	Loop on $i$.
		SET	$0,k		    		Return carry.
		POP	1,0				\slug
%%%off