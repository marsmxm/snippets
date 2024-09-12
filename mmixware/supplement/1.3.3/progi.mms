%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	1.3.3/progi.mms
%	Author:	M.Ruckert
%	Title:	Program I, Inverse in place
	PREFIX	:progi:
x	IS	$0
n	IS	$1
m	IS	$2
j	IS	$3
i	IS	$4

%%%on
:Invert	SUBU	x,x,1	1	&$\.x.\is\.LOC($X[0]$).$.
	SET	m,n	1	&\ut I1. Initialize.\\
	NEG	j,1	1	&$j\is -1$.
2H	LDB	i,x,m	N	&\ut I2. Next element.\\ $i\is X[m]$.
	BN	i,5F	N\bg{N-C}	&To I5 if $i<0$.
3H	STB	j,x,m	N	&\ut I3. Invert one.\\ $X[m]\is j$.
	NEG	j,m	N	&$j\is -m$.
	SET	m,i	N	&$m\is i$.
	LDB	i,x,m	N	&$i\is X[m]$.
4H	PBP	i,3B	N\bg{C}	&\ut I4. End of cycle?.\\ To I3 if $i>0$.
	SET	i,j	C	&Otherwise set $i\is j$.
5H	NEG	i,i	N	&\ut I5. Store final value.\\ $i\is -i$.
	STB	i,x,m	N	&$X[m]\is i$.
6H	SUB	m,m,1	N	&\ut I6. Loop on $m$.\\ 
	BP	m,2B	N\bg{1}	&To I2 if $m>0$.\quad\slug
%%%rt 1.3.3progi.rt & (13N+C+5)\upsilon
%%%off
	POP	0,0
