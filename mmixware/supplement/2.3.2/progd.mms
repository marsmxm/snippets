%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.3.2/progd.mms
%	Author:	Chan Vinh VONG <chanvinh.vong@gmail.com>
% 		adapted by M. Ruckert
%	Title:	Program D, Differentiation Routines

RLINK		IS 0
LLINK    	IS 8
INFO		IS 16
DIFF		IS 22 
		PREFIX	:D:

y       	IS $0		1. Parameter
x		IS $1		2. Parameter 
rJ 		IS $2
info    	IS $3
diff    	IS $4
p		IS $5
p1      	IS $6
p2      	IS $7
q1      	IS $8
q       	IS $9		just before t
t       	IS $10
dy		IS $11
%%%on
%%%	%*&Differentiation in a Right-Threaded Tree
%%\mmsskip	
:D   	GET   	rJ,:rJ
	LDOU  	p1,y,:LLINK  	  &\ut D1. Initialize.\\ $\.P1.\is \.LLINK(Y).$, prepare to find \.Y\sd..
1H      SET  	p,p1  	  	  &$\.P.\is \.P1.$.
2H      LDOU  	p1,p,:LLINK	  &$\.P1.\is \.LLINK(P).$.
        BNZ   	p1,1B       	  &If $\.P1.\ne\Lambda$, repeat.
%%%
D2      LDWU  	diff,p,:DIFF	  &\ut D2. Differentiate.\\ 
%%%
	GETA  	t,:Const	&^{GETA+<GETA> (get address)}
	GO    	t,t,diff	&Jump to the differentiation method.^{GO+<GO> (go to location)}
%%%        
D3      STOU  	p2,p1,:RLINK &\ut D3. Restore link.\\  $\.RLINK(P1).\is \.P2.$.
%%%        
D4      SET   	p2,p		&\ut D4. Advance to \.P.\sdsl.\\ $\.P2.\is \.P.$.
        LDOU  	p,p,:RLINK	&$\.P.\is \.RLINK(P).$.
        BOD   	p,1F         	&Jump if $\.RTAG(P).=1$;
        STOU  	q,p2,:RLINK	&\qquad otherwise, set $\.RLINK(P2).\is \.Q.$.
	JMP   	2B		& Note that \.Node(P\sd). will be terminal.
%%% 
1H	ANDN	p,p,1		&Remove tag from \.P..       
D5      CMP   	t,p,y		&\ut D5. Done?\\ 
	LDOU  	p1,p,:LLINK	&$\.P1.\is\.LLINK(P).$, prepare for step D2.
	LDOU  	q1,p1,:RLINK	&$\.Q1.\is\.RLINK(P1).$.
	BNZ   	t,D2		&Jump to D2 if $\.P.\ne \.Y.$\hair;
	PUSHJ 	dy,:Allocate     &\qquad otherwise, allocate \.DY..
	STOU  	q,dy,:LLINK	&$\.LLINK(DY).\is \.Q.$.
	STOU  	dy,dy,:RLINK	&$\.RLINK(DY).\is \.DY.$.
	OR    	t,dy,1		&		
        STOU  	t,q,:RLINK	&$\.RLINK(Q).\is \.DY.$, $\.RTAG(Q).\is 1$.
	PUT 	:rJ,rJ		&
        SET 	$0,dy           &Return \.DY..
        POP 	1,0		&Exit from differentiation subroutine.\quad\slug
%%%
%%%off
	PREFIX	:

