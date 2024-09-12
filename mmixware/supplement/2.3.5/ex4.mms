%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.3.5/ex4.mms
%	Author:	Chan Vinh VONG <chanvinh.vong@gmail.com>
%	Title:	Exercise 4, Algorithm E (Marking)
% Draft Version 2012 April 8th
% Edited by Martin Ruckert
% Added optimizations by Martin Ruckert
%
% The MIX version of the exercise requires a node to be stored in one
% word. For MMIX, we will use two OCTAs per node with the following
% structure:
%
%  >|<-------OCTA------>|<
%   +-------------------+
%   | ALINK/63 (MARK/1) | (BA+0)
%   +-------------------+
%   | BLINK/63 (ATOM/1) | (BA+8)
%   +-------------------+
%
% Notes:
% - {A|B}LINK targets other nodes and are thus octa-byte aligned
% - MARK=1 or ATOM=1 will make {A|B}LINK change their parity
% - when ATOM=1, {A|B}LINK may contain addresses of data stored
%   elsewhere in memory using any alignment except one-byte alignment
%   due to the existence of MARK|ATOM bit flags
%


% Calling Sequence:
%     $1 <- PO
%     PUSHJ $0,MARK
%
        PREFIX :Mark:

P       IS $0		%%%tex p
T       IS $1		%%%tex t
Q       IS $2		%%%tex q
R	IS $3		%%%tex r
t       IS $4		%%%tex x

ALINK  IS 8*0
BLINK  IS 8*1
NODE   IS 8*2

%%%on
%%\noalign{\sourcenext}
:Mark	SET T,0		 1 &\ut E1. Initialize.\\ $\.T.\is\Lambda$.
        PUT :rM,1	 1 &Prepare for \.MUX.ing the tag bits.^{MUX+<MUX> (multiplex)}^{rM+rM (multiplex mask register)}
%%%	T, P, and Q have 0 tags.
%%%        
E2      LDOU t,P,ALINK	 1 &	\ut E2. Mark \.P..\\
        OR   t,t,1	 1 &
        STOU t,P,ALINK	 1 & 	$\.MARK(P). \is 1$.
%%%        
%%%        E3. Go up if atom
E3      LDOU t,P,BLINK	 1 &	\ut E3. Atom?\\
        PBEV  t,E4	 1\bg{0} &	Jump if $\.ATOM(P).=0$.
%%%        
%%%        Rewire and go up
E6      BZ   T,9F   	 n\bg{1} &     \ut E6. Up.\\ 
        SET  Q,T    	 n-1 &     $\.Q. \is \.T.$.
        LDOU T,Q,BLINK	 n-1 &	 $\.T. \is \.BLINK(Q).$.
        PBOD  T,1F     	 n-1\bg{t_2} &   Jump if $\.ATOM(T). = 1$.
        STOU P,Q,BLINK	 t_2 & 	 $\.BLINK(Q). \is \.P.$.
        SET  P,Q      	 t_2 &   $\.P. \is \.Q.$.
        JMP E6 		 t_2 &
%%%
1H      ANDN T,T,1	 t_1 & Remove tag bit from \.T..
        STOU T,Q,BLINK 	 t_1 &   $\.ATOM(Q). \is 0$.
        LDOU t,Q,ALINK 	 t_1 &   $\.t. \is \.ALINK(Q).$.
        ANDN T,t,1 	 t_1 &   $\.T.\is \.ALINK(Q).$ without mark bit.
        MUX  t,t,P 	 t_1 &   $\.t.\is \.P.$ retaining \.MARK(Q)..^{MUX+<MUX> (multiplex)}
        STOU t,Q,ALINK	 t_1 &  $\.ALINK(Q). \is \.P.$ retaining \.MARK(Q)..
        SET  P,Q 	 t_1 &         $\.P. \is \.Q.$.
%%%
%%%        move on BLINK
E5      LDOU R,P,BLINK 	 n &	\ut E5. Down \.BLINK..\\ $\.R.\is \.BLINK(P).$.
        ANDN Q,R,1 	 n &	  $\.Q. \is \.BLINK(P).$ without atom bit.
        BZ   Q,E6  	 n\bg{b_2} &        Jump if $\.Q. = \Lambda$.
        LDOU t,Q,ALINK 	 n-b_2 & 
        BOD  t,E6   	 n-b_2\bg{t_1+1-b_2-a_2} &       Jump if $\.MARK(Q). = 1$.
	OR   t,t,1 	 t_2+a_2 &	  Set mark bit.
	STOU t,Q,ALINK 	  t_2+a_2 &	  $\.MARK(Q).\is 1$.
	LDOU t,Q,BLINK	  t_2+a_2 &
	BOD  t,E6	  t_2+a_2\bg{a_2} &    Jump if $\.ATOM(Q).=1$.
        MUX  R,R,T 	  t_2 & 	  $\.R.\is \.T.$ retaining \.ATOM(P)..^{MUX+<MUX> (multiplex)}
        STOU R,P,BLINK	  t_2 &    $\.BLINK(P). \is \.T.$ retaining \.ATOM(P)..
E4A     SET  T,P	  n-1 &          $\.T. \is \.P.$.
        SET  P,Q	 n-1 &     	  $\.P. \is \.Q.$.
%%%        
%%%        move on ALINK
E4      LDOU R,P,ALINK	 n &	  \ut E4. Down \.ALINK..\\ $\.Q.\is \.ALINK(P).$.
        ANDN Q,R,1	 n &    $\.Q. \is \.ALINK(P).$ without mark bit.
        BZ   Q,E5	 n\bg{b_1} &         Jump if $\.Q. = \Lambda$.
        LDOU t,Q,ALINK	 n-b_1 &
        BOD  t,E5	 n-b_1\bg{t_2+1-b_1-a_1} &         Jump if $\.MARK(Q). = 1$.
	OR   t,t,1	 t_1+a_1 &	  Set mark bit.
	STOU t,Q,ALINK	 t_1+a_1 &	  $\.MARK(Q).\is  1$.
	LDOU t,Q,BLINK	 t_1+a_1 &
	BOD  t,E5	 t_1+a_1\bg{a_1} &	Jump if $\.ATOM(Q).=1$.
	LDOU t,P,BLINK	 t_1 &
        OR   t,t,1	 t_1 &	Set atom bit.
        STOU t,P,BLINK	 t_1 & $\.ATOM(P). \is 1$.
        MUX  R,R,T	 t_1 &		$\.R.\is \.T.$ retaining \.ATOM(P)..^{MUX+<MUX> (multiplex)}
        STOU R,P,ALINK	 t_1 & 		$\.ALINK(P). \is \.T.$ retaining \.ATOM(P)..
	JMP  E4A	 t_1 &
%%%
9H      POP 0,0		     &\slug
%%%off   
     	PREFIX :
