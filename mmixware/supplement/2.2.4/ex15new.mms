%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.4/ex15new.mms
%	Author:	M.Ruckert
%	Title:	Exercise 15, Mult
% ---------------------------- exercise 2.2.4-15 Program M ------------------------------
%%%     revised version that uses a sentinel like Dons original version
%%%
	PREFIX	:Mult:
COEF    IS      16             &  Definition of coefficient field
ABC     IS      8             &  Definition of ABC exponent field
LINK    IS      0            &  Definition of link field
%%%
q       IS      $0	&	1. parameter
m       IS      $1	&	2. parameter
p	IS	$2	&	3. parameter
%%%	Compute Q \is Q+ M*P
q1      IS      $3	&	Local variables: $\.LINK(Q1).=Q$,
abcp	IS	$4	&	\qquad \.ABC(P).,
coefp	IS	$5	&	\qquad $\.COEF(P).$, 
abcm	IS	$6	&	\qquad $\.ABC(M).$,
coefm	IS	$7	&	\qquad $\.COEF(M).$,
coefq	IS	$8	&	\qquad $\.COEF(Q).$,
q2	IS	$9	
t	IS	$10	&	\qquad and a temporary variable $t$.
%%%on
:Mult	 LDOU	m,m,LINK 	 	r+1   		& \ut M1. Next multiplier.\\ 
	 LDO	abcm,m,ABC 	 	r+1   		& $\.abcm.\is \.ABC(M).$.
	 BN	abcm,9F			r+1\bg{1}	& If $\.ABC(M).<0$, terminate.
	 LDO	coefm,m,COEF	 	r   		& $\.coefm.\is \.COEF(M).$.
%%%
A1	 SET     q1,q			\sum m^{\prime\prime} &   \ut  A1. Initialize.\\ $\.Q1. \is \.Q.$.
         LDOU    q,q,LINK      		\sum m^{\prime\prime} &		   $\.Q. \is \.LINK(Q).$.
0H       LDOU    p,p,LINK      		\sum p &		   $\.P. \is \.LINK(P).$.
         LDO     coefp,p,COEF     	\sum p &		   $\.coefp.\is \.COEF(P).$.
	 MUL	 coefp,coefm,coefp      \sum p &		   $\.coefp.\is \.coefm.\cdot \.coefp.$.
         LDO     abcp,p,ABC      	\sum p &		   \utt  A2. \.ABC(P). : \.ABC(Q)..\\ 
	 NOR	 abcp,abcp,0      	\sum p &		  $\.abcp.\is \.abcm.+ \.abcp.$ by:^{NOR+<NOR> (bitwise not-or)}
	 WDIF	 abcp,abcp,abcm    	\sum p &	   	  \qquad invert, parallel subtract,^{WDIF+<WDIF> (wyde difference)}
	 NOR	 abcp,abcp,0     	\sum p &		  \qquad and invert.	
2H       LDO     t,q,ABC       		\sum x &		    	   $\.t.\is \.ABC(Q).$.
         CMP     t,abcp,t       	\sum x &		    	   Compare \.abcp. and \.ABC(Q)..
         BZ      t,A3          		\sum x \bg{\sum m+1} &		   If equal, go to A3.
         BP      t,A5          		\sum p^\prime+q^\prime\bg{\sum p^\prime}~ &  If greater, go to A5.
         SET     q1,q          		\sum q^\prime &		   If less, set $\.Q1. \is \.Q.$.
         LDOU    q,q,LINK      		\sum q^\prime &		   $\.Q. \is \.LINK(Q).$.
	 JMP	 2B	       		\sum q^\prime &		   Repeat.
%%%
A3       BN	 abcp,:Mult		\sum m+1\bg{1} &	      	\ut  A3. Add coefficients.\\
         LDO     coefq,q,COEF		\sum m &		       
         ADD     coefq,coefq,coefp      \sum m &		      $\.coefq.\is \.coefq.+\.coefp.$.
         STO     coefq,q,COEF     	\sum m &		       $\.COEF(Q).\is \.coefq.$.
         PBNZ    coefq,A1        	\sum m \bg{\sum m^\prime}~ &	If $\.coefq. \ne 0$, go to A1.
         SET     q2,q           	\sum m^\prime &		     \ut  A4. Delete zero term.\\ 
         LDOU    q,q,LINK      		\sum m^\prime &		      $\.Q. \is \.LINK(Q).$.
         STOU    q,q1,LINK     		\sum m^\prime &		      $\.LINK(Q1). \is \.Q.$.
         STOU    :avail,q2,LINK  	\sum m^\prime &		    
         SET     :avail,q2       	\sum m^\prime &	 		$\.AVAIL. \Leftarrow \.Q2.$.
         JMP     0B            		\sum m^\prime &		      Go to advance \.P..
%%%
A5       SET     q2,:avail		\sum p^\prime &		      \ut  A5. Insert new term.\\ 
         LDOU    :avail,:avail,LINK  	\sum p^\prime &		     $\.Q2. \Leftarrow \. AVAIL.$.
         STO     coefp,q2,COEF     	\sum p^\prime &		     $\.COEF(Q2). \is \.coefp.$.
         STO     abcp,q2,ABC     	\sum p^\prime &		    $\.ABC(Q2). \is \.abcp.$.
         STOU    q,q2,LINK      	\sum p^\prime &		     $\.LINK(Q2). \is \.Q.$.
         STOU    q2,q1,LINK     	\sum p^\prime &		     $\.LINK(Q1). \is \.Q2.$.
         SET     q1,q2          	\sum p^\prime &		     $\.Q1. \is \.Q2.$.
	 JMP	 0B	       		\sum p^\prime &		      Go to advance \.P..
%%%
9H	 POP     0,0				      & 		Return from subroutine.\quad\slug
%%%off
	PREFIX	:
% ---------------------------- Program M ------------------------------
