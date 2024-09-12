%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2/progc2.mms
%	Author: Martin Ruckert
%	rewritten program by 
%	Author: Kenneth Laskoski <kennethlaskoski@po...>
%	removed again from progc.mms  doubling of SUB j,j,8; PBNN j,4B to avoid JMP
%	Author: Wijtze de Boer <agricola@xs...>
%	except see above and a (wrong) BP instead of BNN.
%	Title:	Program C, Comparison counting
%
	PREFIX	:Sort:
%%%
k	IS	$0	      &Parameter. 	
count	IS	$1		
n	IS	$2	      
i	IS	$3	      &Local variables.
j	IS	$4
ki	IS	$5			
kj	IS	$6
cj	IS	$7
ci	IS	$8
t	IS	$9
%%%
%%%on
:Sort	SL	i,n,3		1 &\ut C1. Clear \.COUNT.s.\\
       	JMP	0F		1 &
1H     	STCO	0,count,i	N & $\.COUNT[$i$].\is 0$.
0H     	SUB	i,i,8		N+1 &
       	PBNN	i,1B		N+1\bg{1} & $N>i\ge0$.
	SL	i,n,3		1 &\ut C2. Loop on $i$.\\
       	JMP	1F		1 &
2H	LDO	ci,count,i	N-1 &\lineref|5.2-c-2H|
	LDO	ki,k,i		N-1 &
3H	LDO	kj,k,j		A   &
	CMP	t,ki,kj		A &\subfoolit{j}\ut C4. Compare $K_i:K\!$\setfool.\\
	PBNN	t,4F		A\bg{B} &Jump if $K_i\ge K_j$.\lineref|5.2-c-to4F|
	LDO	cj,count,j	B & \.COUNT[$j$].
	ADD	cj,cj,8		B & \quad ${}+1$
	STO	cj,count,j	B & \quad\quad$\rightarrow \.COUNT[$j$].$.
	JMP	5F		B &\lineref|5.2-c-to5F|
4H	ADD	ci,ci,8		A-B &$\.COUNT[$i$]. \is \.COUNT[$i$].+1$.\lineref|5.2-c-4H|
5H	SUB	j,j,8		A &\foolit{j}\ut C3. Loop on \setfool.\\
	PBNN	j,3B		A\bg{N-1} &
     	STO	ci,count,i	N-1 &
1H	SUB	i,i,8		N &
	SUB	j,i,8		N &$N> i > j\ge 0$.
       	PBNN	j,2B		N\bg{1} &\slug
%%%rt 5.2progc2.rt    & (11N+6A+5B+5)\upsilon + (4N+A+2B-3)\mu 
%%%off
	POP	0,0
%%%
	PREFIX	:
%%%on