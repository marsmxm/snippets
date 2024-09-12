%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.4/ex15b.mms
%	Program 5.2.4L
%	Author:	M. Ruckert
%	Title:	Exercise 15, Program L, expanded
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
N	IS	$1


link	IS	$2	
p	IS	$3
q	IS	$4
kp	IS	$5	
kq	IS	$6	
s	IS	$7
linkn1	IS	s	
s0	IS	$8	$\.s._0$
t	IS	$9
c	IS	$10	

%%%
:Sort	SL	N,N,3	    1 &		\ut  L1. Prepare two lists.\\
	ADDU	link,key,4	    1 &		$L\is L_0$.		   
%%%
	SUB	p,N,16	    1 &		$p\is N-2$.
	BN	p,9F	    1\bg{0} &		Terminate if $N<2$.
	OR	q,N,1	    1 &		$q\is N^-$.
0H	STTU	q,link,p	    N-2 &		$L_p\is q$.
	SUB	q,q,8	    N-2 &		$q\is (q-1)^-$.
	SUB	p,p,8	    N-2 &		$p\is p-1$.
	PBP	p,0B	    N-2 \bg{1} &		Repeat until $p=0$.
%%%
	SET	c,8|1	    1 &		
	STTU	c,link,0	    1 &		$L_0\is 1^-$.
	SUB	c,N,8	    1 &		
	ADDU	linkn1,c,link	    1 &		$L_{N-1}\is L+8(N-1)$.
	SET	c,16|1	    1 &
	STTU	c,linkn1,16    1 &		$L_{N+1}\is 2^-$.		
	SET	c,0|1	    1 &		
	STTU	c,linkn1,8	    1 &		$L_N\is 0^-$.		
	STTU	c,linkn1,0	    1 &		$L_{N-1}\is 0^-$.		
	JMP	L2	    1 &
%%%
%%%
%%% This is the big picture: there are 6 labels L3: L3pqs, L3psq, L3qps, L3qsp, L3spq, L3sqp
%%% depending on the six permutations of p, q, and s 
%%% L3 has two instructions: 	CMP	c,kp,kq; BP c,L6xxx
%%% so there are six copies of L4 and L6 each that follow.
%%% each followed by another copy of L4 and L6 where L_s=p or L_s=q is known.
%%% Each of these copies have either an exit to L5 or L7, so there are 6 variations of these
%%% entry points needed too.
%%%
%%%on
L3pqs	CMP	c,kp,kq	   &	\subfoolit{p}\othersubfoolit{q}\ut  L3. Compare $K$\setfool${}:{} K$\setotherfool.\\
	BP	c,L6pqs	   &	If $K_p>K_q$, go to L6pqs.
L4pqs	STTU	p,link,s	   &	\foolit{p}\ut  L4. Advance \setfool.\\ $L_s\is p$.
%%%	SET	s,p	   &	$s\is p$.
	LDTU	s,link,p	   &	$p\is L_p$.
%%%	sqp
	LDT	kp,key,s	   &	$\.kp.\is K_p$.
	BOD	s,L5sqp	   &	If $\.TAG($p$).=1$, continue with L5sqp.
%%%
L34sqp	CMP	c,kp,kq	   &	\subfoolit{p}\othersubfoolit{q}\ut  L3. Compare $K$\setfool${}:{} K$\setotherfool.\\
	BP	c,L6sqp	   &	If $K_p>K_q$, go to L6sqp.
%%%	SET	s,p	   &	\foolit{p}\ut  L4. Advance \setfool.\\ $s\is p$.
	LDTU	p,link,s	   &	\foolit{p}\ut  L4. Advance \setfool.\\ $p\is L_s$.
%%%	pqs
	LDT	kp,key,p	   &	$\.kp.\is K_p$.
	BOD	p,L5pqs	   &	If $\.TAG($p$).=1$, continue with L5pqs.
%%%
L34pqs	CMP	c,kp,kq	   &	\subfoolit{p}\othersubfoolit{q}\ut  L3. Compare $K$\setfool${}:{} K$\setotherfool.\\
	BP	c,L6pqs	   &	If $K_p>K_q$, go to L6pqs.
%%%	SET	s,p	   &	\foolit{p}\ut  L4. Advance \setfool.\\ $s\is p$.
	LDTU	s,link,p	   &	\foolit{p}\ut  L4. Advance \setfool.\\ $s\is L_p$.
%%%	sqp
	LDT	kp,key,s	   &	$\.kp.\is K_s$.
	PBEV	s,L34sqp   &	If $\.TAG($p$).=0$, continue with L34sqp.
L5sqp	STTU	q,link,p	   &	\ut  L5. Complete the sublist.\\ $L_p\is q$.
	SET	p,s	   &	Undo permutation of $(p,q,s)$.
	JMP	L5A
%%%
L4psq	STTU	p,link,q	   &	\foolit{p}\ut  L4. Advance \setfool.\\ $L_q\is p$.
%%%	SET	s,p	   &	$s\is p$.
	LDTU	q,link,p	   &	$q\is L_p$.
%%%	qsp
	LDT	kp,key,q	   &	$\.kp.\is K_q$.
	BOD	q,L5qsp	   &	If $\.TAG($q$).=1$, continue with L5qsp.
%%%
L34qsp	CMP	c,kp,kq	   &	\subfoolit{p}\othersubfoolit{q}\ut  L3. Compare $K$\setfool${}:{} K$\setotherfool.\\
	BP	c,L6qsp	   &	If $K_p>K_q$, go to L6qsp.
%%%	SET	s,p	   &	\foolit{p}\ut  L4. Advance \setfool.\\ $s\is p$.
	LDTU	p,link,q	   &	\foolit{p}\ut  L4. Advance \setfool.\\ $p\is L_q$.
%%%	psq
	LDT	kp,key,p	   &	$\.kp.\is K_p$.
	BOD	p,L5psq	   &	If $\.TAG($p$).=1$, continue with L5psq.
%%%
L34psq	CMP	c,kp,kq	   &	\subfoolit{p}\othersubfoolit{q}\ut  L3. Compare $K$\setfool${}:{} K$\setotherfool.\\
	BP	c,L6psq	   &	If $K_p>K_q$, go to L6psq.
%%%	SET	s,p	   &	\foolit{p}\ut  L4. Advance \setfool.\\ $s\is p$.
	LDTU	q,link,p	   &	\foolit{p}\ut  L4. Advance \setfool.\\ $q\is L_p$.
%%%	qsp
	LDT	kp,key,q	   &	$\.kp.\is K_q$.
	PBEV	q,L34qsp   &	If $\.TAG($q$).=0$, continue with L34qsp.
L5qsp	STTU	s,link,p	   &	\ut  L5. Complete the sublist.\\ $L_p\is s$.
	SET	p,q	   &	Undo permutation of $(p,q,s)$.
	SET	q,s	   &
	JMP	L5A	   &
%%%
L4spq	STTU	s,link,q	   &	\foolit{p}\ut  L4. Advance \setfool.\\ $L_s\is p$.
%%%	SET	s,p	   &	$s\is p$.
	LDTU	q,link,s	   &	$q\is L_s$.
%%%	qps
	LDT	kp,key,q	   &	$\.kp.\is K_q$.
	BOD	q,L5qps	   &	If $\.TAG($q$).=1$, continue with L5qps.
%%%
L34qps	CMP	c,kp,kq	   &	\subfoolit{p}\othersubfoolit{q}\ut  L3. Compare $K$\setfool${}:{} K$\setotherfool.\\
	BP	c,L6qps	   &	If $K_p>K_q$, go to L6qps.
%%%	SET	s,p	   &	\foolit{p}\ut  L4. Advance \setfool.\\ $s\is p$.
	LDTU	s,link,q	   &	\foolit{p}\ut  L4. Advance \setfool.\\ $s\is L_q$.
%%%	spq
	LDT	kp,key,s	   &	$\.kp.\is K_s$.
	BOD	s,L5spq	   &	If $\.TAG($s$).=1$, continue with L5spq.
L34spq	CMP	c,kp,kq	   &	\subfoolit{p}\othersubfoolit{q}\ut  L3. Compare $K$\setfool${}:{} K$\setotherfool.\\
	BP	c,L6spq	   &	If $K_p>K_q$, go to L6spq.
%%%	SET	s,p	   &	\foolit{p}\ut  L4. Advance \setfool.\\ $s\is p$.
	LDTU	q,link,s	   &	\foolit{p}\ut  L4. Advance \setfool.\\ $q\is L_s$.
%%%	qps
	LDT	kp,key,q	   &	$\.kp.\is K_q$.
	PBEV	q,L34qps   &	If $\.TAG($q$).=0$, continue with L34qps.
L5qps	STTU	p,link,s	   &	\ut  L5. Complete the sublist.\\ $L_s\is p$.
	SET	s,p	   &	Undo permutation of $(p,q,s)$.
	SET	p,q
	SET	q,s
	JMP	L5A
%%%
L4qps	STTU	q,link,s	   &	\foolit{p}\ut  L4. Advance \setfool.\\ $L_s\is q$.
%%%	SET	s,p	   &	$s\is p$.
	LDTU	s,link,q	   &	$s\is L_q$.
%%%	spq
	LDT	kp,key,s	   &	$\.kp.\is K_s$.
	PBEV	s,L34spq   &    If $\.TAG($s$).=0$, continue with L34spq.
L5spq	STTU	p,link,q	   &	\ut  L5. Complete the sublist.\\ $L_q\is p$.
	SET	q,p	   &	Undo permutation of $(p,q,s)$.
	SET	p,s
	JMP	L5A
%%%
L4sqp	STTU	s,link,p	   &	\foolit{p}\ut  L4. Advance \setfool.\\ $L_p\is s$.
%%%	SET	s,p	   &	$s\is p$.
	LDTU	p,link,s	   &	$p\is L_s$.
%%%	spq
	LDT	kp,key,p	   &	$\.kp.\is K_p$.
	PBEV	p,L34pqs   &	If $\.TAG($s$).=0$, continue with L34pqs.
%%%
L5pqs	STTU	q,link,s	   &	\ut  L5. Complete the sublist.\\ $L_s\is q$.
L5A	SET	s,t	   &	$s\is t$.
0H	SET	t,q	   &	$t\is q$.
  	LDTU	q,link,q	   &	$q\is L_q$.
	BEV	q,0B	   &	Repeat until  If $\.TAG($q$).=1$.
	LDT	kq,key,q	   &	$\.kq.\is K_q$.
	JMP	L8	   &	
%%%
L4qsp	STTU	q,link,p	   &	\foolit{p}\ut  L4. Advance \setfool.\\ $L_p\is q$.
%%%	SET	s,p	   &	$s\is p$.
	LDTU	p,link,q	   &	$p\is L_q$.
%%%	psq
	LDT	kp,key,p	   &	$\.kp.\is K_p$.
	PBEV	p,L34psq   &	If $\.TAG($p$).=0$,  continue with L34psq.
L5psq	STTU	s,link,q	   &	\ut  L5. Complete the sublist.\\ $L_q\is s$.
	SET	q,s	   &	Undo permutation of $(p,q,s)$.
	JMP	L5A
%%%off
%%% L4 done next comes L6
%%%
L6pqs	STTU	q,link,s	   &	\foolit{p}\ut  L6. Advance \setfool.\\ $L_s\is q$.
%%%	SET	s,q	   &	$s\is q$.
	LDTU	s,link,q	   &	$q\is L_q$.
%%%	psq
	LDT	kq,key,s	   &	$\.kq.\is K_q$.
	BOD	s,L7psq	   &	If $q^-$, continue with L7.
%%%
L36psq	CMP	c,kp,kq	   &	\subfoolit{p}\othersubfoolit{q}\ut  L3. Compare $K$\setfool${}:{} K$\setotherfool.\\
	BNP	c,L4psq	   &
%%%	SET	s,q	   &	\foolit{q}\ut  L6. Advance \setfool.\\ $s\is q$.
	LDTU	q,link,s	   &	\foolit{q}\ut  L6. Advance \setfool.\\ $q\is L_q$.
%%%	pqs
	LDT	kq,key,q	   &	$\.kp.\is K_p$.
	BOD	q,L7pqs	   &	If $q^-$, continue with L7.
%%%
L36pqs	CMP	c,kp,kq	   &	\subfoolit{p}\othersubfoolit{q}\ut  L3. Compare $K$\setfool${}:{} K$\setotherfool.\\
	BNP	c,L4pqs	   &
%%%	SET	s,q	   &	\foolit{q}\ut  L6. Advance \setfool.\\ $s\is q$.
	LDTU	s,link,q	   &	\foolit{q}\ut  L6. Advance \setfool.\\ $q\is L_q$.
%%%	psq
	LDT	kq,key,s	   &	$\.kq.\is K_q$.
	PBEV	s,L36psq   &	If $q^-$, continue with L7.
L7psq	STTU	p,link,q
	SET	q,s
	JMP	L7A
%%%
%%%
L6sqp	STTU	q,link,p	   &	\foolit{p}\ut  L6. Advance \setfool.\\ $L_s\is q$.
%%%	SET	p,q	   &	$s\is q$.
	LDTU	p,link,q	   &	$q\is L_q$.
%%%	spq
	LDT	kq,key,p	   &	$\.kq.\is K_q$.
	BOD	p,L7spq	   &	If $q^-$, continue with L7.
%%%
L36spq	CMP	c,kp,kq	   &	\subfoolit{p}\othersubfoolit{q}\ut  L3. Compare $K$\setfool${}:{} K$\setotherfool.\\
	BNP	c,L4spq	   &
%%%	SET	p,q	   &	\foolit{q}\ut  L6. Advance \setfool.\\ $s\is q$.
	LDTU	q,link,p	   &	\foolit{q}\ut  L6. Advance \setfool.\\ $q\is L_q$.
%%%	sqp
	LDT	kq,key,q	   &	$\.kp.\is K_p$.
	BOD	q,L7sqp	   &	If $q^-$, continue with L7.
%%%
L36sqp	CMP	c,kp,kq	   &	\subfoolit{p}\othersubfoolit{q}\ut  L3. Compare $K$\setfool${}:{} K$\setotherfool.\\
	BNP	c,L4sqp	   &
%%%	SET	p,q	   &	\foolit{q}\ut  L6. Advance \setfool.\\ $s\is q$.
	LDTU	p,link,q	   &	\foolit{q}\ut  L6. Advance \setfool.\\ $q\is L_q$.
%%%	spq
	LDT	kq,key,p	   &	$\.kq.\is K_q$.
	PBEV	p,L36spq   &	If $q^-$, continue with L7.
L7spq	STTU	s,link,q
	SET	q,p
	SET	p,s
	JMP	L7A
%%%
L6spq	STTU	p,link,q	   &	\foolit{p}\ut  L6. Advance \setfool.\\ $L_s\is q$.
%%%	SET	q,p	   &	$s\is q$.
	LDTU	q,link,p	   &	$q\is L_q$.
%%%	sqp
	LDT	kq,key,q	   &	$\.kq.\is K_q$.
	PBEV	q,L36sqp   &	If $q^-$, continue with L7.
L7sqp	STTU	s,link,p
	SET	p,s
	JMP	L7A
%%%
%%%
L6qps	STTU	p,link,s	   &	\foolit{p}\ut  L6. Advance \setfool.\\ $L_s\is q$.
%%%	SET	s,p	   &	$s\is q$.
	LDTU	s,link,p	   &	$q\is L_q$.
%%%	qsp
	LDT	kq,key,s	   &	$\.kq.\is K_q$.
	BOD	s,L7qsp	   &	If $q^-$, continue with L7.
%%%
L36qsp	CMP	c,kp,kq	   &	\subfoolit{p}\othersubfoolit{q}\ut  L3. Compare $K$\setfool${}:{} K$\setotherfool.\\
	BNP	c,L4qsp	   &
%%%	SET	s,p	   &	\foolit{q}\ut  L6. Advance \setfool.\\ $s\is q$.
	LDTU	p,link,s	   &	\foolit{q}\ut  L6. Advance \setfool.\\ $q\is L_q$.
%%%	qps
	LDT	kq,key,p	   &	$\.kp.\is K_p$.
	BOD	p,L7qps	   &	If $q^-$, continue with L7.
%%%
L36qps	CMP	c,kp,kq	   &	\subfoolit{p}\othersubfoolit{q}\ut  L3. Compare $K$\setfool${}:{} K$\setotherfool.\\
	BNP	c,L4qps	   &
%%%	SET	s,p	   &	\foolit{q}\ut  L6. Advance \setfool.\\ $s\is q$.
	LDTU	s,link,p	   &	\foolit{q}\ut  L6. Advance \setfool.\\ $q\is L_q$.
%%%	qsp
	LDT	kq,key,s	   &	$\.kq.\is K_q$.
	PBEV	s,L36qsp   &	If $q^-$, continue with L7.
L7qsp	STTU	q,link,p
	SET	p,q
	SET	q,s
	JMP	L7A
%%%
L6qsp	STTU	s,link,p	   &	\foolit{p}\ut  L6. Advance \setfool.\\ $L_s\is q$.
%%%	SET	p,s	   &	$s\is q$.
	LDTU	p,link,s	   &	$q\is L_q$.
%%%	qps
	LDT	kq,key,p	   &	$\.kq.\is K_q$.
	PBEV	p,L36qps   &	If $q^-$, continue with L7.
L7qps	STTU	q,link,s
	SET	s,p
	SET	p,q
	SET	q,s
	JMP	L7A
%%%
L6psq	STTU	s,link,q	   &	\foolit{p}\ut  L6. Advance \setfool.\\ $L_s\is q$.
%%%	SET	q,s	   &	$s\is q$.
	LDTU	q,link,s	   &	$q\is L_q$.
%%%	pqs
	LDT	kq,key,q	   &	$\.kq.\is K_q$.
	PBEV	q,L36pqs   &	If $q^+$, continue with L7.
%%%
L7pqs	STTU	p,link,s	    B^{\prime\prime} &	\ut  L7. Complete the sublist.\\  $L_s\is p$.
L7A	SET	s,t	    B^{\prime\prime} &	$s\is t$.
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
	PBNZ	q,L3pqs	    B \bg{A}&		If $q\ne 0$, go to L3.
	SET	c,1	    A &		
	STTU	c,link,t	    A &		$L_t\is 0^-$.
	OR	p,p,1	    A &
	STTU	p,link,s	    A &		$L_s\is p^-$.
%%%
L2	SET	s,0	    A+1 &		\ut  L2. Begin new pass.\\ $s\is 0$.
	SET	s0,s	    A+1 &		$s_0\is s$.
	ADDU	t,N,8	    A+1 &		$t\is N-1$.
	LDTU	p,link,s	    A+1 &		$p\is L_s$.
	ANDN	p,p,1	    A+1 &		$p\is p^+$.
	LDTU	q,link,t	    A+1 &		$q\is L_t$.
	ANDN	q,q,1	    A+1 &		$q\is q^+$.
	LDT	kp,key,p	    A+1 &		$\.kp.\is K_p$.
	LDT	kq,key,q	    A+1 &		$\.kq.\is K_q$.
	PBNZ	q,L3pqs	    A+1 \bg{1} &		Terminate if $q=0$.
%%%
9H	POP	0,0			&\slug
%%%off