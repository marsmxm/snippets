%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	6.2.1/fsearch2.mms
%	Author:	M. Ruckert
%	Title:	Program F, Fibonaccian search
% simple Fibonacci search
		PREFIX	:fsearch:
key		IS	$0		 Parameter.
k		IS	$1		
i		IS	$2
p		IS	$3
q		IS	$4
ki		IS	$5		
t		IS	$6		

%%%on
F4A		ADD	i,i,q	C_2-S-A & \ut  F4. Increase $i$.\\ $i\is i+q$.\lineref|6.2.1fsearch2.astart|
		SUB	p,p,q	C_2-S-A & $p\is p-q$.
		SUB	q,q,p	C_2-S-A & $q\is q-p$.
%%%
:Search		LDO	ki,key,i	C &\ut  F2. Compare.\\ 
		CMP	t,k,ki	C & 
		PBN	t,F3A 	C\bg{C_2} &  To F3 if $K< K_i$.
		BZ	t,Success C_2\bg{S} &	Exit if $K= K_i$.
%%%
		CMP	t,p,8	C_2-S & 
		PBNZ	t,F4A	C_2-S\bg{A} & To F4 if $p\ne 1$.
		POP	0,0	           & Exit if not in table.
%%%
F3A		SUB	i,i,q	C_1 & \ut  F3. Decrease $i$.\\ $i\is i-q$.
		SUB	p,p,q	C_1 & $p\is p-q$.
		PBP	q,F2B	C_1\bg{1-S-A}	   & Swap registers if $q>0$. \lineref|6.2.1fsearch2.aend|
		POP	0,0           & Exit if not in table.
%%%
F4B		ADD	i,i,p		 & \lineref|6.2.1fsearch2.bstart|(Lines |6.2.1fsearch2.bstart|--|6.2.1fsearch2.bend| are 
		SUB	q,q,p		 &\hfill parallel to |6.2.1fsearch2.astart|--|6.2.1fsearch2.aend|.)
		SUB	p,p,q	
%%%
F2B		LDO	ki,key,i	
		CMP	t,k,ki	
		PBN	t,F3B	
		BZ	t,Success
%%%
		CMP	t,q,8	
		PBNZ	t,F4B	
		POP	0,0	
%%%
F3B		SUB	i,i,p	
		SUB	q,q,p	
		PBP	p,:Search	\lineref|6.2.1fsearch2.bend|
%%%
		POP	0,0
Success		ADDU	$0,key,i	S & Return \.LOC($K_i$)..
		POP	1,0	  &\slug
%%%off
		PREFIX	:


