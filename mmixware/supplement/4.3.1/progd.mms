%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.3.1/progd.mms
%	Author:	M.Ruckert
%	Title:	Program D, Division of nonnegative integers
	PREFIX	:Classic:

u	IS	$0	Parameters.
v	IS	$1
q	IS	$2
nu	IS	$3
m	IS	$3	Alias for nu
nv	IS	$4

rJ	IS	$5
vn1	IS	$6	Local variables.
vn2	IS	$7
k	IS	$8
uji	IS	$9
j	IS	$10
uj	IS	$11
qh	IS	$12
rh	IS	$13
pl	IS	$14
pm	IS	$15
i	IS	$16
ujn	IS	$17
ld	IS	$18
t	IS	$19


%%%on
:Div	GET	rJ,:rJ				 1	&
	SL	nv,nv,3; SL nu,nu,3		 1	&
	SUB	t,nv,8	  			 1	&\ut  D1. Normalize.\\
	LDOU 	ld+1,v,t			 1	&
	PUSHJ 	ld,:LeadingZeros		 1	&See new exercise 4.2.1--20.
	SET	t+1,v; SR t+2,nv,3		 1	&
	SET 	t+3,ld				 1	&
	PUSHJ	t,:ShiftLeft	      	  	 1	&See new exercise 25.
	SET	t+1,u; SR t+2,nu,3		 1	&
	SET 	t+3,ld				 1	&
	PUSHJ	t,:ShiftLeft			 1	&See new exercise 25.
	SET	ujn,t				 1	&$u_{j+n}\is \hbox{carry}$.
%%%
	SUB	m,nu,nv				 1	&$m\is n_u-n_v$.
	SET 	j,m			 	 1	&\foolit{j}\ut  D2. Initialize \setfool.\\ $j\is m$.
	ADDU	v,nv,v				 1	&  $\.v.\is \.LOC($v$).+8n$.
	NEG 	t,8; LDOU vn1,v,t		 1	&  $\.vn1.\is v_{n-1}$.
	NEG 	t,16; LDOU vn2,v,t		 1	&  $\.vn2.\is v_{n-2}$.
	ADDU	uj,j,u				 1	&
	ADDU    uj,nv,uj			 1      & $\.uj.\is \.LOC($u$).+8(j+n)$.
	JMP	0F				 1   & Avoid loading $u_{m+n}$.
%%%
D3	LDOU	ujn,uj,0			 M   &\foolit{\hat{q}}\ut  D3. Calculate \setfool.\\
0H	CMPU	t,ujn,vn1			 M+1 &
	BNN	t,1F				 M+1\bg{0} & Jump if $\hat{q}$ would be $b$.
	NEG	i,8				 M+1 &$i\is n-1$. 
	LDOU uji,uj,i				 M+1 &Get $u_{j+n-1}$.
%%%
	PUT	:rD,ujn				 M+1 &$\.rD.\is u_{j+n}$.
	DIVU	qh,uji,vn1			 M+1 &$\hat{q}\is \lfloor (u_{j+n}b+u_{j+n-1})/v_{n-1}\rfloor$.
	GET	rh,:rR				 M+1 &$\hat{r}\is \cdots \mod v_{n-1}$.
	JMP	2F				 M+1 &
1H	SET	qh,0				        & $\hat{q}\is b$.\lineref|4.3.1progdno1|
	SET	rh,uji					& $\hat{r}\is u_{j+n}=v_{n-1}$.\lineref|4.3.1progdno2|
3H	SUBU	qh,qh,1				 E & Decrease $\hat{q}$ by one.
	ADDU	rh,rh,vn1			 E & $\hat{r}\is \hat{r}+v_{n-1}$.
	CMPU	t,rh,vn1			 E &Check if overflow.
	BN	t,D4				 E \bg{E-F} &If yes, continue the test.
%%%
%%%	SWYM					 F & this instruction shows F in the profile	
%%%						     measured E=714 F=439
%%%
%%% here about e/2 disappears from the loop to D4, the next part will be used
%%% by about e/2 less than indicated, this is compensated below in the jump to D4
%%% with a smlaller number than M+1 so that at D4 we have M+1.
%%% This is how Don Knuth has his analysis.
%%%
2H	MULU	pl,qh,vn2			 M+F+1 &$p_mb+p_l \is \hat{q}v_{n-2}$.
	GET	pm,:rH				 M+F+1 &^{rH+rH (himult register)}^{Himult register}
	CMPU	t,pm,rh				 M+F+1 &Compare high 64 bits.
	PBN 	t,D4 				 M+F+1\bg{E} &
	PBP 	t,3B				 E\bg{0} &
	NEG	i,16					& $i\is n-2$.\lineref|4.3.1progdno3|
	LDOU 	uji,uj,i					& Get $u_{j+n-2}$.
	CMPU	t,pl,uji					& Compare low 64 bits.
	BP 	t,3B					&\lineref|4.3.1progdno4|
%%%
D4	SET	k,0				 M+1 & \ut  D4. Multiply and subtract.\\
   	NEG 	i,nv			 	 M+1 &  $i\is 0$.
0H	LDOU	uji,uj,i			 N(M+1) & Load $u_{j+i}$.
	LDOU	t,v,i				 N(M+1) & $\.t.\is v_i$.
	MULU	pl,t,qh				 N(M+1) & $(p_m,p_l)\is v_i\times \hat{q}$.
	GET	pm,:rH				 N(M+1) &
	ADDU	pl,pl,k				 N(M+1) & $(p_m,p_l)\is (p_m,p_l)+k$.
	CMPU	t,pl,k; ZSN k,t,1		 N(M+1) & Carry from $p_l$ to $p_m$?
	ADDU	pm,pm,k				 N(M+1) &
	CMPU	t,uji,pl; ZSN 	k,t,1		 N(M+1) & Carry from $u_{j+i}-p_l$?
	SUBU 	uji,uji,pl			 N(M+1) &$u_{j+i}\is u_{j+i}-v_i\times\hat{q}$.	
	STOU	uji,uj,i			 N(M+1) &Store $u_{j+i}$.
	ADDU    k,pm,k				 N(M+1) &Add $p_m$ to carry.
	ADD	i,i,8				 N(M+1) &$i\is i+1$.
	PBN	i,0B				 N(M+1)\bg{M+1} &Repeat for $0\le i < n$.
%%%
	SUBU 	uji,ujn,k				 M+1 & Complete D4 for $i=n$.
	CMPU	t,ujn,k				 M+1 &
	ZSN 	k,t,1				 M+1 & Borrow to the left?
	CMP	t,j,m; BNN t,D5			 M+1\bg{1} &Store unless $j=m$.
	STOU	uji,uj,i			 M &$u_{j+n}\is u_{j+n}+\hbox{carry}$.
%%%				
D5	PBZ	k,1F				 M+1\bg{0} &\ut  D5. Test remainder.\\
%%%
	SUBU	qh,qh,1				&\ut  D6. Add back.\\
	NEG 	i,nv    			&$i \is -8n$.
	SET	k,0   	   			&$\hbox{Carry} \is 0$.
0H	LDOU	uji,uj,i			&
	ADDU uji,uji,k				&$u_{j+i}\is u_{j+i}+\hbox{carry}$.
	ZSZ 	k,uji,k				&Carry?
	LDOU	t,v,i				&$\.t.\is v_i$.
	ADDU uji,uji,t				&$u_{j+i}\is u_{j+i}+v_i$.	
	CMPU	t,uji,t				&
	CSN k,t,1				&Carry?
	STOU	uji,uj,i			&
	ADD	i,i,8				&
	PBN	i,0B				&Probably $j<0$.
	LDOU	uji,uj,i			&
        ADDU uji,uji,k				&
	STOU	uji,uj,i			&$u_{j+n}\is u_{j+i}+\hbox{carry}$.
1H	STOU	qh,q,j		 		 M+1 &$q_j\is \hat{q}$.
%%%	
D7	SUB	uj,uj,8				 M+1 &\foolit{j}\ut  D7. Loop on \setfool.\\
	SUBU	j,j,8				 M+1 & $j\is j-1$.
	PBNN	j,D3				 M+1\bg{1} &
	SET	t+1,u				 1	&\ut  D8. Unnormalize.\\
	SR	t+2,nv,3			 1	&
	SET	t+3,ld				 1	&
	PUSHJ	t,:ShiftRight			 1	&See exercise 26.
%%%				
	PUT	:rJ,rJ				 1 	&
	POP	0,0				 	&\slug
%%%off