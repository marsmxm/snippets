%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.4/ex11new.mms
%	Author:	M.Ruckert
%	Title:	Exercise 11, Copy
% Call with PUSHJ $R,Copy, with polynomial in $(R+1) 
% The polynomial pointed to by $(R+1) is copied and returned
%%%
	PREFIX	:Copy:
COEF    IS      16             &  Definition of coefficient field
ABC     IS      8             &  Definition of ABC exponent field
LINK    IS      0            &  Definition of link field
%%%
p       IS      $0		&Parameter
q       IS      $1		&Local variables: the copy of \.P.,
q0	IS	$2		&the address of highest element in \.Q..
t	IS	$3		&and a temporary variable $t$.
%%%on
:Copy	SET	q0,:avail		 1 &The future backlink
1H	SET	q,:avail		 p &$\.Q.\is \.AVAIL.$.
	LDOU	:avail,:avail,LINK	 p &$\.AVAIL.\is\.LINK(AVAIL).$.
	LDOU	p,p,LINK		 p &Advance \.P..
	LDO	t,p,COEF		 p &
	STO	t,q,COEF		 p &$\.COEF(Q).\is \.COEF(P).$.
	LDOU	t,p,ABC			 p &
	STOU	t,q,ABC			 p &$\.ABC(Q).\is \.ABC(P).$.
	PBNN	t,1B			 p\bg{1} &Was $\.ABC.\ne 0$?
	STOU	q0,q,LINK		 1 &Store backlink to \.LINK(Q)..
	SET	$0,q			 1 &
	POP	1,0			   &Return \.Q..\quad\slug
%%%off
	PREFIX	: