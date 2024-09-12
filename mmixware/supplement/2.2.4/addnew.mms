%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.4/addnew.mms
%	Author:	M.Ruckert
%	Title:	Program A, Addition of polynomials
% ---------------------------- Program A ------------------------------
% Call with PUSHJ $R,Add, with polynomials in $(R+1) and $(R+2)
% The polynomial pointed to by $(R+1) is added to $(R+2)
%% This version of add uses a sentinel with ABC = -1 as Dons original version does.
	PREFIX	:Add:
COEF    IS      16             &  Definition of coefficient field
ABC     IS      8              &  Definition of ABC exponent field
LINK    IS      0            &  Definition of link field
%%%  	Parameter
p       IS      $0	 
q       IS      $1	
%%%	Local variables: $\.LINK(Q1).=\.Q.$,
q1      IS      $2	$\.Q._1$
q2	IS	$3
abcp	IS	$4	&	\qquad \.ABC(P).,
coefp	IS	$5	${\.coef.}_{\.P.}$
coefq	IS	$6	${\.coef.}_{\.Q.}$
t	IS	$7	&	\qquad and a temporary variable $t$.

%%%on
:Add      SET     q1,q			1+m^{\prime\prime} 	&\ut  A1. Initialize.\\ $\.Q1. \is \.Q.$.
         LDOU    q,q,LINK      		1+m^{\prime\prime} 	&$\.Q. \is \.LINK(Q).$.
0H       LDOU    p,p,LINK      		1+p 		   	&$\.P. \is \.LINK(P).$.
         LDO     coefp,p,COEF     	1+p 		   	&$\.coefp.\is \.COEF(P).$.
         LDO     abcp,p,ABC      	1+p			&\utt  A2. \.ABC(P). : \.ABC(Q)..\\
2H       LDO     t,q,ABC       		x 			&$\.t. \is \.ABC(Q).$.
         CMP     t,abcp,t        	x 			&Compare \.ABC(P). and \.ABC(Q)..
         BZ      t,A3          		x\bg{m+1} &		If equal, go to A3.
         BP      t,A5          		p^\prime+q^\prime \bg{p^\prime}~ & If greater, go to A5.
         SET     q1,q          		q^\prime &		If less, set $\.Q1. \is \.Q.$.
         LDOU    q,q,LINK      		q^\prime &		$\.Q. \is \.LINK(Q).$.
	 JMP	 2B	       		q^\prime &		Repeat.
%%%
A3       BN	 abcp,6F		m+1\bg{1} &	      	\ut  A3. Add coefficients.\\
	 LDO     coefq,q,COEF		m &	  		$\.coefq.\is\.COEF(Q).$.
         ADD     coefq,coefq,coefp      m &			$\.coefq.\is \.coefq.+\.coefp.$.
         STO     coefq,q,COEF      	m &		       	$\.COEF(Q).\is \.COEF(Q).+\.COEF(P).$.
         PBNZ    coefq,:Add         	m \bg{m^\prime}~ &	Jump if nonzero.
         SET     q2,q           	m^\prime &		\ut  A4. Delete zero term.\\ $\.Q2.\is\.Q.$.
         LDOU    q,q,LINK      		m^\prime &		$\.Q. \is \.LINK(Q).$.
         STOU    q,q1,LINK     		m^\prime &		$\.LINK(Q1). \is \.Q.$.
         STOU    :avail,q2,LINK  	m^\prime &	
         SET     :avail,q2       	m^\prime &		$\.AVAIL. \Leftarrow \.Q2.$.	   
         JMP     0B            		m^\prime &		Go to advance \.P..
%%%
A5       SET     q2,:avail       	p^\prime &		\ut  A5. Insert new term.\\ 
         LDOU    :avail,:avail,LINK  	p^\prime &		$\.Q2.\Leftarrow \.AVAIL.$.
         STO     coefp,q2,COEF     	p^\prime &		$\.COEF(Q2). \is \.COEF(P).$.
         STOU    abcp,q2,ABC     	p^\prime &		$\.ABC(Q2). \is \.ABC(P).$.
         STOU    q,q2,LINK      	p^\prime &		$\.LINK(Q2). \is \.Q.$.
         STOU    q2,q1,LINK     	p^\prime &		$\.LINK(Q1). \is \.Q2.$.
         SET     q1,q2          	p^\prime &		$\.Q1. \is \.Q2.$.
         JMP     0B            		p^\prime &		Go to advance \.P..
6H       POP     0,0          				&Return from subroutine.\quad\slug
%%%off
% ---------------------------- Program A ------------------------------
	 PREFIX	: