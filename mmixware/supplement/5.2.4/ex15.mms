%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.4/ex15.mms
%	Author:	M. Ruckert
%	Title:	Exercise 15, Program L improved
%       instead of negative links, we use odd links
%       inside the inner loop, we do not set the odd-bit
%	on the first link in each run, since this would be to
%	expensive. Instead we keep a pointer $s_0$ to the head of each
%	run and apply the marker bit after the run is finished.
%	records are one OCTA with the first TETRA being the key and the second TETRA the link
%	links are offsets relative to the start of the array
%	two extra records R_0 and R_{n+1} are used as list heads. 
	
	PREFIX	:sort:
key	IS	$0	
n	IS	$1

link	IS	$2
p	IS	$3
q	IS	$4
kp	IS	$5
kq	IS	$6
s	IS	$7
linkn1	IS	s	
s0	IS	$8	
t	IS	$9
c	IS	$10	

%%%
:Sort	SL	n,n,3	    1 &		\ut  L1. Prepare two lists.\\
	ADDU	link,key,4	    1 &		$L\is L_0$.		   
%%
	SUB	p,n,16	    1 &		$p\is N-2$.
	BN	p,9F	    1\bg{0} &		Terminate if $N<2$.
	OR	q,n,1	    1 &		$q\is N^-$.
0H	STTU	q,link,p	    N-2 &		$L_p\is q$.
	SUB	q,q,8	    N-2 &		$q\is (q-1)^-$.
	SUB	p,p,8	    N-2 &		$p\is p-1$.
	PBP	p,0B	    N-2 \bg{1} &		Repeat until $p=0$.
%%%
	SET	c,8|1	    1 &		
	STTU	c,link,0	    1 &		$L_0\is 1^-$.
	SUB	c,n,8	    1 &		
	ADDU	linkn1,c,link	    1 &		$L_{N-1}\is L+8(N-1)$.
	SET	c,16|1	    1 &
	STTU	c,linkn1,16    1 &		$L_{N+1}\is 2^-$.		
	SET	c,0|1	    1 &		
	STTU	c,linkn1,8	    1 &		$L_N\is 0^-$.		
	STTU	c,linkn1,0	    1 &		$L_{N-1}\is 0^-$.		
	JMP	L2	    1 &
%%%
L3	CMP	c,kp,kq	    C &		\foolit{K_p:K_q}\ut  L3. Compare \setfool.\\
	BP	c,L6	    C \bg{C^{\prime\prime}} &
L4	STTU	p,link,s	    C^\prime &	\foolit{p}\ut  L4. Advance \setfool.\\ $L_s\is p$.
	SET	s,p	    C^\prime &	$s\is p$.
	LDTU	p,link,p	    C^\prime &	$p\is L_p$.
	LDT	kp,key,p	    C^\prime &	$\.kp.\is K_p$.
%%%on
	BOD	p,L5	    C^\prime \bg{B^\prime_1} &	If $\.TAG($p$).=0$, continue with L3A.
%%%
L3A	CMP	c,kp,kq	    C^\prime_1 &	\subfoolit{p}\othersubfoolit{q}\ut  L3. Compare $K$\setfool${}:{} K$\setotherfool.\\
	BP	c,L6	    C^\prime_1 \bg{C^{\prime\prime}_1} & If $K_p>K_q$, go to L6.
	SET	s,p	    C^\prime_1 &	\foolit{p}\ut  L4. Advance \setfool.\\	$s\is p$.
	LDTU	p,link,p    C^\prime_1 &	$p\is L_p$.
	LDT	kp,key,p    C^\prime_1 &	$\.kp.\is K_p$.
	PBEV	p,L3A	    C^\prime_1 \bg{B^\prime-B^\prime_1} &If $\.TAG($p$).=0$, return to L3A.
%%%off
L5	STTU	q,link,s	    B^\prime &	\ut  L5. Complete the sublist.\\ $L_s\is q$.
	SET	s,t	    B^\prime &	$s\is t$.
0H	SET	t,q	    D^\prime &	$t\is q$.
	LDTU	q,link,q	    D^\prime &	$q\is L_q$.
	BEV	q,0B	    D^\prime \bg{D^\prime-B^\prime} &	Repeat until $q^-$.
	LDT	kq,key,q	    B^\prime &
	JMP	L8	    B^\prime &	
%%%
L6	STTU	q,link,s	    C^{\prime\prime} &	\foolit{q}\ut  L6. Advance \setfool.\\ $L_s\is q$.
	SET	s,q	    C^{\prime\prime} &	$s\is q$.
	LDTU	q,link,q	    C^{\prime\prime} &	$q\is L_q$.
	LDT	kq,key,q	    C^{\prime\prime} &	$\.kq.\is K_q$.
%%%
	BOD	q,L7	    C^{\prime\prime} \bg{B^{\prime\prime}} &	If $q^+$, continue with L3B.
%%%
L3B	CMP	c,kp,kq	    C &		\foolit{K_p:K_q}\ut  L3. Compare \setfool.\\
	BNP	c,L4	    C \bg{C^{\prime\prime}} &
	SET	s,q	    C^{\prime\prime} &	\foolit{q}\ut  L6. Advance \setfool.\\ $s\is q$.
	LDTU	q,link,q	    C^{\prime\prime} &	$q\is L_q$.
	LDT	kq,key,q	    C^{\prime\prime} &	$\.kq.\is K_q$.
	PBEV	q,L3B	    C^{\prime\prime} \bg{B^{\prime\prime}} &	If $q^+$, return to L3.
%%%
L7	STTU	p,link,s	    B^{\prime\prime} &	\ut  L7. Complete the sublist.\\  $L_s\is p$.
	SET	s,t	    B^{\prime\prime} &	$s\is t$.
0H	SET	t,p	    D^{\prime\prime} &	$t\is p$.
	LDTU	p,link,p	    D^{\prime\prime} &	$p\is L_p$.
	BEV	p,0B	    D^{\prime\prime} \bg{D^{\prime\prime}-B^{\prime\prime}} &	Repeat until $p^-$.
	LDT	kp,key,p	    B^{\prime\prime} &
%%%
L8	LDTU	c,link,s0	    B &		\ut  L8. End of pass?\\
	OR	c,c,1	    B &		
	STTU	c,link,s0	    B &		$L_{s_0}\is L_{s_0}^-$.
	SET	s0,s	    B &		$s_0\is s$.
	ANDN	p,p,1	    B &		$p\is p^+$.		
	ANDN	q,q,1	    B &		$q\is q^+$.
	PBNZ	q,L3	    B \bg{A}&		If $q\ne 0$, go to L3.
	SET	c,1	    A &		
	STTU	c,link,t	    A &		$L_t\is 0^-$.
	OR	p,p,1	    A &
	STTU	p,link,s	    A &		$L_s\is p^-$.
%%%
L2	SET	s,0	    A+1 &		\ut  L2. Begin new pass.\\ $s\is 0$.
	SET	s0,s	    A+1 &		$s_0\is s$.
	ADDU	t,n,8	    A+1 &		$t\is N-1$.
	LDTU	p,link,s	    A+1 &		$p\is L_s$.
	ANDN	p,p,1	    A+1 &		$p\is p^+$.
	LDTU	q,link,t	    A+1 &		$q\is L_t$.
	ANDN	q,q,1	    A+1 &		$q\is q^+$.
	LDT	kp,key,p	    A+1 &		$\.kp.\is K_p$.
	LDT	kq,key,q	    A+1 &		$\.kq.\is K_q$.
	PBNZ	q,L3	    A+1 \bg{1} &		Terminate if $q=0$.
%%%
9H	POP	0,0			&\slug
%%%off