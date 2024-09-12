%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2/progd.mms
% 	Author: Martin Ruckert
%		same to program by 
% 	Author: Kenneth Laskoski <kennethlaskoski@po...>
%		removed again form progc.mms  doubling of SUB j,j,8; PBNN j,4B to avoid JMP
% 	Author: Wijtze de Boer <agricola@xs...>
%		except see above and a (wrong) BP instead of BNN.
%	Title:	Exercise 9, Sorting by distribution counting
	PREFIX	:DCsort:
key	IS	$0	Parameter.
count	IS	$1
s	IS	$2		
n	IS	$3			
u	IS	$4			
v	IS	$5			
count0	IS	$6	Local variables.
countv	IS	$7			
j	IS	$8
i	IS	$9		
kj	IS	$10			
c	IS	$11			
cj	IS	$12			
ci	IS	$13		
rj	IS	$14			
t	IS	$15			

%%%on
:Sort	NEG	t,u		 1 &
	8ADDU	count0,t,count   1 &$\.count0. \is \.count.-8u$.
	8ADDU	countv,v,count0  1 &$\.countv. \is \.count0.+8v$.
	SUBU	i,count,countv	 1 &\ut D1. Clear \.COUNT.s.\\ $i\is u$.
       	JMP	0F		 1 &
1H     	STCO	0,countv,i	 M+1 & $\.COUNT[$j$].\is 0$.
     	ADD	i,i,8		 M+1 & $i\is i+1$.
0H     	PBNP	i,1B		 M+1\bg{1} & $u\le i \le v$.
	SL	j,n,3		 1 &\foolit{j}\ut D2. Loop on \setfool.\\ $j\is N+1$.
       	JMP	2F		 1 &
3H	LDWU	kj,key,j	 	 N &\subfoolit{j}\utt D3. Increase \.COUNT[.$K$\setfool\.]..\\
	SL	kj,kj,3		 N &
	LDO	c,count0,kj	 N & \.COUNT[$K_j$].
	ADD	c,c,8		 N & \quad ${}+1$
	STO	c,count0,kj	 N &\quad\quad $\rightarrow\.COUNT[$K_j$].$.
2H	SUB	j,j,8		 N+1 & $j\is j-1$.
       	PBNN	j,3B		 N+1\bg{1} &$N> j\ge 0$. 
	SUB	i,count,countv	 1 &\ut D4. Accumulate.\\ $i\is u$.
	LDO	c,countv,i	 1 & $c\is \.COUNT[$i$].$.
	JMP	4F		 1 &
0H	LDO	ci,countv,i	 M & \.COUNT[$i$].	
	ADD	c,ci,c		 M & \quad${}+\.COUNT[$i-1$].$
	STO	c,countv,i	 M & \quad\quad$\rightarrow \.COUNT[$i$].$.
4H	ADD	i,i,8		 M+1 & $i\is i+1$.
	PBNP	i,0B		 M+1\bg{1} & $u\le i \le v$.
	SL	j,n,3		 1 &\foolit{j}\ut D5. Loop on \setfool.\\ $j\is N$.
	JMP	5F		 1 &
6H	LDOU	rj,key,j	 	 N &\subfoolit{j}\ut D6. Output $R$\setfool.\\
	SRU	kj,rj,48-3	 N &	Extract $8K_j$.
	LDO	i,count0,kj	 N &  $i\is \.COUNT[$K_j$].$.
	SUB	i,i,8		 N & $i\is i-1$.
	STO	i,count0,kj	 N & $\.COUNT[$K_j$].\is i$.
	STOU	rj,s,i	 	 N & $S_i\is R_j$.
5H	SUB	j,j,8		 N+1 &  $j\is j-1$.
	PBNN	j,6B		 N+1\bg{1} &\slug
%%%rt 5.2progd.rt  & (15N+8M+29)\upsilon + (7N+3M+2)\mu 
%%%off
	POP	0,0

	PREFIX	:
%%%on