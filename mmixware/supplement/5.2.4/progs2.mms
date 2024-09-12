%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.4/progs2.mms
%	Implementation of Program 5.2.4S
%       see exercise 5.2.4-9
%	Author:	M.Ruckert
%	Title:	Exercise 9, Program S, Straight two-way merge sort
	PREFIX	:sort:

% its possible to optimize away r and q by introducing Kr and Kq
% such that i=8q and j=8r and Kr and Kq adjust for the differences when accessing the array
% this turns the algorithm into a 9N\lg N search !
% which is even better than quicksort.

key	IS	$0	Parameter	
key2	IS	$1	Second array
n	IS	$2	size

i	IS	$3
j	IS	$4
k	IS	$5
l	IS	$6
d	IS	$7
p	IS	$8
ki	IS	$9
kj	IS	$10
q	IS	$11
r	IS	$12
ji	IS	$13
t	IS	$14


%%%on
:Sort	SL	n,n,3	 1		&\ut S1. Initialize.\\
	SET	p,8	 1		&$p\is 1$.
%%%
S2	ADDU	q,key,p	 A		&\ut S2. Prepare for pass.\\  $\.q.\is \.LOC($R_{1+p}$).$.
	NEG	i,p	 A		&$i\is 1$ (\.i. is relative to \.q.).
	LDO	ki,q,i	 A		&$\.ki.\is K_i$.	
	ADDU	r,key,n	 A		& $\.r.\is \.LOC($R_{N+1}$).$.
	SUB	r,r,8	 A		& $\.r.\is \.LOC($R_{N}$).$.
	SUB	r,r,p	 A		& $\.r.\is \.LOC($R_{N-p}$).$.
	SET	j,p	 A		& $j\is N$ (\.j. is relative to \.r.).
	LDO	kj,r,j	 A		&$\.kj.\is K_j$.	
	NEG	k,8	 A		&$k\is -1$.
	SET	l,n	 A		&$l\is N$.	
	SET	d,8	 A		&$d\is 1$.
%%%
S3	CMP	t,ki,kj	 C			&\subfoolit{j}\ut S3. Compare $K_i:K$\setfool.\\
	BP	t,S8	 C\bg{C^{\prime\prime}}	&If $K_i>K_j$, go to S8.\lineref|5.2.4progs2a|
	ADD	k,k,d	 C^\prime		&\ut S4. Transmit $R_i$.\\ $k\is k+d$.
	STO	ki,key2,k	 C^\prime		&$R_k\is R_i$.
	ADD	i,i,8	 C^\prime		&\ut S5. End of run?\\ $i\is i+1$.
	LDO	ki,q,i	 C^\prime		&$\.ki.\is K_i$.
	PBN	i,S3	 C^\prime\bg{B^\prime}	&If $q>0$, go to S3.\lineref|5.2.4progs2b|
%%%
S6	ADD	k,k,d	 D^\prime	&\subfoolit{j}\ut S6. Transmit $R$\setfool.\\ $k\is k+d$.
	CMP	t,k,l	 D^\prime	&
	BZ	t,S13	 D^\prime\bg{A^\prime}	&If $k=l$, go to S13.
	STO	kj,key2,k	 D^\prime-A^\prime	&$R_k\is R_j$.
	SUB	j,j,8	 D^\prime-A^\prime	&\ut S7. End of run?\\ $j\is j-1$.
	LDO	kj,r,j	 D^\prime-A^\prime	&$\.kj.\is K_j$.
	PBNP	j,S12	 D^\prime-A^\prime\bg{D^\prime-B^\prime}	&If $r\le 0$, go to S12;
	JMP	S6	 D^\prime-B^\prime	&\qquad otherwise, go to S6.
%%%
S8	ADD	k,k,d	 C^{\prime\prime}	&\subfoolit{j}\ut S8. Transmit $R$\setfool.\\  $k\is k+d$.
	STO	kj,key2,k	 C^{\prime\prime}	&$K_k\is K_j$.
	SUB	j,j,8	 C^{\prime\prime}	&\ut S9. End of run?\\ $j\is j-1$.
	LDO	kj,r,j	 C^{\prime\prime}	&$\.kj.\is K_j$.
	PBP	j,S3	 C^{\prime\prime}\bg{B^{\prime\prime}}	&If $r>0$, go to S3.\lineref|5.2.4progs2c|
%%%
S10	ADD	k,k,d	 D^{\prime\prime}		&\ut S10. Transmit $R_i$.\\  $k\is k+d$.
	CMP	t,k,l	 D^{\prime\prime}		&
	BZ	t,S13	 D^{\prime\prime}\bg{A^{\prime\prime}}		&If $k=l$, go to S13.
	STO	ki,key2,k	 D^{\prime\prime}-A^{\prime\prime}		& $R_k\is R_i$.
	ADD	i,i,8	 D^{\prime\prime}-A^{\prime\prime}		&\ut S11. End of run?\\ $i\is i+1$.
	LDO	ki,q,i	 D^{\prime\prime}-A^{\prime\prime}		&$\.ki.\is K_i$.
	BN	i,S10	 D^{\prime\prime}-A^{\prime\prime}\bg{D^{\prime\prime}-B^{\prime\prime}}		&If $q>0$, go to S10.
%%%
S12	SUB	ji,r,q   B-A		&\ut S12. Switch sides.\\ $\.ji.\is j-i$.
	ADDU	q,q,p	 B-A		&$q\is p$.
	NEG	i,p	 B-A		&\.i. is relative to \.q..
	SUB	r,r,p	 B-A		&$r\is p$.
	SET	j,p	 B-A		&\.j. is relative to \.r..
	NEG	d,d	 B-A		&$d\is -d$.
	SET	t,l	 B-A		&Interchange $k\leftrightarrow l$.
	SET	l,k	 B-A		&
	SET	k,t	 B-A		&
	CMP	t,ji,p	 B-A		&
	PBNN	t,S3	 B-A\bg{E}	&If $j-i\ge p$, go to S3;
	JMP	S10	 E		&\qquad otherwise, go to S10.
%%%
S13	ADD	p,p,p	 A		&\ut S13. Switch areas.\\ $p\is p+p$.
	CMP	t,p,n	 A		&
	BNN	t,0F 	 A\bg{1}	&If $p\ge N$, sorting is complete.
	SET	t,key2	 A-1		&Interchange $\.key2.\leftrightarrow \.key.$.
	SET	key2,key	 A-1		&	
	SET	key,t	 A-1		&
	JMP	S2	 A-1		&Go to S2.
%%%
0H	SET	$0,key2	 1		&Return \.key2..
	POP	1,0			&\slug
%%%off