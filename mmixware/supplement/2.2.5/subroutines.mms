%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.5/subroutines.mms
%	Author:	M.Ruckert
%	Title:	Subroutines
%%%on
%%%
		LOC	    #100
%%%
%%%		Subroutines
%%%
		PREFIX	     :queue:		\lineref|2.2.5queue|\pageref|2.2.5queuepage|
p		IS	     $0			Parameter for \.Insert.
q		IS	     $1			Local variable
:Insert		LDOU	     q,p,:LLINK2     	Insert \.NODE(C). to left of \.NODE(P)..
		STOU	     q,:c,:LLINK2
		STOU	     :c,p,:LLINK2
		STOU	     :c,q,:RLINK2
		STOU	     p,:c,:RLINK2
		POP	     0,0
%%%
:Delete		LDOU	     p,:c,:LLINK2	Delete \.NODE(C). from its list.\lineref|2.2.5delstart|
		LDOU	     q,:c,:RLINK2
		STOU	     p,q,:LLINK2
		STOU	     q,p,:RLINK2	\lineref|2.2.5delend|
		POP	     0,0		\lineref|2.2.5queueend|
%%%
%%\mmsskip
		PREFIX	     :wait:
tc		IS	     $0			Parameter for \.SortIn.
q		IS	     $1			Local variables
p		IS	     $2
tp		IS	     $3
t		IS	     $4
%%%
:Immed		SET	     tc,:time		Insert \.NODE(C). first in \.WAIT. list.
		STTU	     tc,:c,:NEXTTIME
		SET	     p,:wait
		JMP	     2F			
%%%
:Hold		ADDU	     tc,:time,:dt	Add delay \.dt. to current \.TIME..
%%%
:SortIn		STTU	     tc,:c,:NEXTTIME	Sort \.NODE(C). into \.WAIT. list.
		SET	     p,:wait		$\.P.\is\.wait.$.
1H		LDOU	     p,p,:LLINK1	$\.P.\is\.LLINK1(P).$.\lineref|SortInLoop|
		LDTU	     tp,p,:NEXTTIME	$\.tp.\is\.NEXTTIME(P).$.
		CMP	     t,tp,tc		Compare \.NEXTTIME. fields, right to left.
		BP	     t,1B 		Repeat until  $\.tp.\le \.tc.$.\lineref|SortInLoopEnd|
2H		LDOU	     q,p,:RLINK1	Insert \.NODE(C). right of \.NODE(P)..
		STOU	     q,:c,:RLINK1
		STOU	     p,:c,:LLINK1
		STOU	     :c,p,:RLINK1
		STOU	     :c,q,:LLINK1
		POP	     0,0
%%%
:DeleteW	LDOU	     p,:c,:LLINK1	Delete \.NODE(C). from \.WAIT. list.
		LDOU	     q,:c,:RLINK1	(This is the same as lines |2.2.5delstart|--|2.2.5delend|
		STOU	     p,q,:LLINK1	\quad except \.LLINK1.\hair, \.RLINK1. are used
		STOU	     q,p,:RLINK1	\quad instead of \.LLINK2.\hair, \.RLINK2..)
		POP	     0,0		\slug
%%%off