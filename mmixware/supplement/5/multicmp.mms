%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5/multicmp.mms
%	Author:	M.Ruckert
%	Title:	Exercise 7, subroutine MCmp
%%%on
	PREFIX	:MCmp: (Begin of local symbols for subroutine \.MCmp.)
%%\mmsskip
n	IS	$0	$n>0$
a	IS	$1	$\.LOC($a_0$).\hphantom{b_j}\smash{\left.\vcenter to 33pt{\vfil}\right\}}$\quad Parameters
b	IS	$2	\.LOC($b_0$).
%%\mmsskip
aj	IS	$3	$a_j$
bj	IS	$4	$b_j\hphantom{\.LOC($a_0$).}\smash{\left.\vcenter to 33pt{\vfil}\right\}}$\quad Local variables
j	IS	$5	$j$
%%\mmsskip
%%%
:MCmp	SUB	j,n,1     \.:MCmp. is a global symbol. $j\is n-1$.
0H	LDBU	aj,a,j	  Load $a_j$.
	LDBU	bj,b,j    Load $b_j$.
	CMPU	$0,aj,bj  Compare $a_j$ and $b_j$.
	BNZ	$0,1F	  Jump if \.\$0. is not zero.
	SUB	j,j,1	  $j\is j-1$.
	PBNN	j,0B	  Loop while $j\ge 0$.
1H	POP	1,0	  Return the value in \.\$0..
%%\mmsskip
	PREFIX	:	(End of local symbols for subroutine \.MCmp.)\quad\slug 
%%%off
