%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.5/ex4.mms
%	Author:	Chan Vinh VONG <chanvinh.vong@gmail.com>
%	Title:	Exercise 4, Algorithm A : First-Fit Method
% Draft Version 2012 April 8th
% Edited September 2012 by Martin Ruckert
%
% Notes:
% - the block header must fit in one OCTA otherwise requesting a block
%   of one OCTA would lead to the allocation of the entire block header
%   i.e more than one OCTA; e.g if the header block is made of 2 OCTAs,
%   one for LINK and the other for SIZE then if requesting N = 1 when
%   SIZE = 2, then the entire block header must be freed, thus we
%   introduced one unallocated and unreachable OCTA;
% - memory is segmented anyway, so using one full OCTA for LINK would
%   be quite an over-engineered solution.
%
% Henceforth, we use the following data structure for a block header:
%
%                         TETRA    TETRA
%                       +--------+--------+
%                       |  SIZE  |  LINK  |
%                       +--------+--------+
%
% - a negative LINK is a NULL address, hence LINK is effectively on 31
%   bits
% - LINK is a relative address to the start of a 8*(2^31-1) bytes sized
%   area in memory dedicated to allocation/pooling; thus, the value of
%   LINK is the number of OCTAs to be added to the base address,
% - 2^31-1 OCTAs is 16G, sounds reasonable
% - managing more memory would just require an entry directory for
%   dispatching to multiple 16G segments; the overhead may be of about
%   2 or 3 OCTAs per such 16G segments, which is more than affordable
%   (one may store the total available size of the segment in an entry
%   in order to speed up the next request or give some priority so that
%   allocation is spread evenly in all segments),
% - SIZE indicates how many OCTAs are available (because LINK is octa-
%   aligned, byte-level allocation would lead to wasted bytes).
%
% Calling Sequence:
%     PUSHJ $X,Allocate
% Entry Condition: N = $0 > 0,  Number of octabytes requested
% 	OCTA	   :AVAIL contains pointer to first node
%       GREG 	   :BASE base address of the memory pool
% Exit Conditions:
%     return address of requested block, octa aligned 
%     else 0 if the program could not allocate memory 

        PREFIX :Allocate:
n       IS 	$0 % requested number of bytes
q	IS	$1
p	IS	$2
s	IS	$3
k	IS	$4
link	IS	$5
t	IS	$6	
SIZE	IS	0
LINK	IS	4
%%%on
:Allocate	ADDU	link,:base,LINK
size		IS	:base
		LDA	p,:AVAIL	\ut  A1. Initialize.\\ 	$\.P.\is\.LOC(AVAIL).$.
		SUBU	p,p,link	Convert to relative address.
%%\mmsskip		
1H		SET	q,p		$\.Q.\is\.P.$.
        	LDT	p,q,link	\ut  A2. End of list?\\ $\.P.\is\.LINK(Q).$.
		BN	p,9F		If $\.P.=\Lambda$, no room.
		LDT	s,p,size	\ut  A3. Is \.SIZE. enough?\\ 
		SUB	k,s,n	$\.K.\is \.SIZE(P).-\.N.$.
		PBN	k,1B		Jump if $\.N. >\.SIZE(P).$.
%%\mmsskip
		PBNZ	k,1F		\ut  A4. Reserve \.N..\\ 	
		LDT	t,p,link	If $\.K.=0$,
		STT	t,q,link	\qquad set $\.LINK(Q).\is\.LINK(P).$.
1H		STT	k,p,size	$\.SIZE(P).\is \.K.$.
		ADD	p,p,k		$\.P.+\.K.$.
		ADDU	$0,p,:base	Convert $\.P. + \.K.$ to an absolute address
		POP	1,0		\qquad and return it.
%%%
9H	 	POP 	0,0		Return $\Lambda$.\quad\slug
%%%off        
        PREFIX :
