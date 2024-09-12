%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	6.2.1/usearch10ex.mms
%	Author:	M. Ruckert
%	Title:	Exercise 10, Uniform search with expanded delta array

key		IS	$0		Parameter.
i		IS	$0		share register with key
k		IS	$1		

l		IS	$2		Local variables.
ki		IS	$3		
t		IS	$4		
%%%on
:Search		ADDU	i,key,8*5-8	$i\is \.DELTA[$1$].$, $\.DELTA[$1$].=5$.
		LDO	ki,i,0		$\.ki.\is K_5$.
		CMP	t,k,ki		Compare $K:K_5$.
		BZ	t,Success		
		ADDU	i,i,8*3		$i\is i+\.DELTA[$2$].$, $\.DELTA[$2$].=3$.
		SUBU	l,i,2*8*3      $l\is i -2\.DELTA[$2$].$.
		CSN	i,t,l		If $K<K_5$, then $i\is l$.
%%%
		LDO	ki,i,0		$\.ki.\is K_{2,8}$.
		CMP	t,k,ki		Compare $K:K_{2,8}$.	
		BZ	t,Success		
		ADDU	i,i,8*1		$i\is i+\.DELTA[$3$].$, $\.DELTA[$3$].=1$.	
		SUBU	l,i,2*8*1	$l\is i -2\.DELTA[$3$].$.
		CSN	i,t,l		If $K<K_{2,8}$, then $i\is l$.	
%%%
		LDO	ki,i,0		$\.ki.\is K_{1,3,7,9}$.
		CMP	t,k,ki		Compare $K:K_{1,3,7,9}$.	
		BZ	t,Success		
		ADDU	i,i,1*8		$i\is i+\.DELTA[$4$].$, $\.DELTA[$4$].=1$.	
		SUBU	l,i,2*8*1	$l\is i -2\.DELTA[$4$].$.
		CSN	i,t,l		If $K<K_{1,3,7,9}$, then $i\is l$.
%%%
		LDO	ki,i,0		$\.ki.\is K_{0,2,2,4,6,8,8,10}$.
		CMP	t,k,ki		Compare $K:K_{0,2,2,4,6,8,8,10}$.
		BZ	t,Success		
%%%
Failure		POP	0,0
Success		POP	1,0		\slug
%%%off