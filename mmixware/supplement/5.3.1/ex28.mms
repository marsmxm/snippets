%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.3.1/ex28.mms
%	Author:	M. Ruckert
%	Title:	Exercise 28, short version
% Following the text page 183 to 184
% using the sequence: load, test and branch, store

K	IS	$0	Parameter, Address of five Octabytes
a	IS	$1	
b	IS	$2	
c	IS	$3	
d	IS	$4	
e	IS	$5	
t	IS	$6	
x	IS	$7	&^{x+<x> (temporary variable)}

%%%on
:Sort	LDB	a,K,0	1&
	LDB	b,K,1	1&	
	LDB	c,K,2	1&	
	LDB	d,K,3	1&	
	LDB	e,K,4	1&	
%%%
	CMP	t,a,b	1&	
	CSP	x,t,a	1&		$a \leftrightarrow b $.
	CSP	a,t,b	1&	
	CSP	b,t,x	1&		
%%%
	CMP	t,c,d	1&	 	Here $a<b$.
	CSP	x,t,c	1&		$c \leftrightarrow d $.
	CSP	c,t,d	1&	
	CSP	d,t,x	1&		
%%%
	CMP	t,b,d	1&		Here $c<d$.\lineref|5.3.1swapbdstart|	
	BN	t,2F	1\bg{1/2}&	
	SET	x,a	1/2&		$a \leftrightarrow c $.
	SET	a,c	1/2&	
	SET	c,x	1/2&	
	SET	x,b	1/2&		$b \leftrightarrow d $.
	SET	b,d	1/2&	
	SET	d,x	1/2&		\lineref|5.3.1swapbdend|
%%%
2H	CMP	t,e,b	1&	        Here $a<b<d$ and $c<d$.
	BP	t,3F	1\bg{7/15}&
%%%
	CMP	t,e,a	8/15&	        Here $a<b<d$, $e<b$, and $c<d$.
	SET	x,e	8/15&		$x \is e$.
	SET	e,b	8/15&	 	$e \is b$.
	CSNP	b,t,a	8/15&	 	If $e<a$, $b\is a$.
	CSNP	a,t,x	8/15&	 	If $e<a$, $a\is x$.
	CSP	b,t,x	8/15&	 	If $e>a$, $b\leftrightarrow e$. 
0H	STB	d,K,4	4/5&	 	Here $a<b<e<d$ and $c<d$.
%%%
	CMP	t,c,b	4/5&	
	BP	t,5F	4/5\bg{2/5}&	
%%%	
	STB	e,K,3	2/5&	 	Here $a<b<e<d$ and $c<b$.
1H	STB	b,K,2	8/15&	
	CMP	t,c,a	8/15&	
	BP	t,6F	8/15\bg{4/15}&	
%%%	
	STB	c,K,0	4/15&	 	Here $c<a<b<e<d$.
	STB	a,K,1	4/15&	
	POP	0,0
%%%
6H	STB	a,K,0	4/15&	 	Here $a<c<b<e<d$.
	STB	c,K,1	4/15&	
	POP	0,0
%%%
%%%
5H	STB	a,K,0	2/5&	 	Here $a<b<e<d$ and $b<c<d$.
	STB	b,K,1	2/5&	
	CMP	t,c,e	2/5&	
	BN	t,6F	2/5\bg{1/5}&	
%%%
	STB	e,K,2	1/5&	 	Here $a<b<e<c<d$.
	STB	c,K,3	1/5&	
	POP	0,0
%%%
6H	STB	e,K,3	1/5&	 	Here $a<b<c<e<d$.
	STB	c,K,2	1/5&	
	POP	0,0
%%%
3H	CMP	t,e,d	7/15& 	 	Here $a<b<d$, $b<e$, and $c<d$.
	PBN	t,0B	7/15\bg{1/5} &
%%%	
	STB	e,K,4	1/5&	 	Here $a<b<d<e$ and $c<d$.
	STB	d,K,3	1/5&	
	CMP	t,c,b	1/5& 	
	PBN	t,1B	1/5\bg{1/15}&	
%%%
	STB	a,K,0	1/15&		Here $a<b<c<d<e$.
	STB	b,K,1	1/15&
	STB	c,K,2	1/15&
	POP	0,0		&\slug
%%%off


