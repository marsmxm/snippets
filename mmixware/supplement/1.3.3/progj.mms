%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	1.3.3/progj.mms
%	Author:	M.Ruckert
%	Title:	Program J, Inverse in place
	PREFIX	:progj:
x	IS	$0
n	IS	$1
m	IS	$2
j	IS	$3
i	IS	$4
k	IS	$5

%%%on
:Invert	SUBU	x,x,1	1	&$\.x.\is\.LOC($X[0]$).$.
	SET	k,n	1	&\ut J1. Negate all.\\
0H	LDB	i,x,k	N	&$i\is X[k]$.
	NEG	i,i	N	&$i \is -i$.
	STB	i,x,k	N	&$X[k]\is i$.
	SUB	k,k,1	N	&Continue 
	PBP	k,0B	N\bg{1}	&\quad while $k>0$.
	SET 	m,n	1	&$m\is n$.
2H	SET	i,m	N	&\ut J2. Initialize.\\ $i\is m$.
0H	SET	j,i	A	&$j\is i$.
	LDB	i,x,j	A	&\ut J3. Find negative entry.\\ $i\is X[j]$.
	PBP	i,0B	A\bg{N}	&$i>0$?
	NEG	i,i	N	&\ut J4. Invert.\\ $i\is -i$.
	LDB	k,x,i	N	&$k\is X[i]$.
	STB	k,x,j	N	&$X[j]\is k$.
	STB	m,x,i	N	&$X[i]\is m$.
	SUB	m,m,1	N	&\ut J5. Loop on $m$.\\ 	
	BP	m,2B	N\bg{1}	&To J2 if $m>0$.\quad\slug
%%%off
	POP	0,0
