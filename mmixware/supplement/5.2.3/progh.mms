%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.3/progh.mms
%	Author:	Jan-Hendrik Behrmann 2012
%		M. Ruckert renamed to adapt to other programs 
%	Title:	Program H, Heapsort
* MMIX-Implementierung des Heapsort-Algorithmus
* =============================================

        PREFIX	  :sort:

key	IS $0	 Adresse des Arrays
n	IS $1	 Anzahl der Elemente

l	IS $2	scaled 		* linke Grenze des Heaps
r	IS $3	scaled		* rechte Grenze des Heaps
i	IS $4	scaled		* Position des aktuellen Knotens
k	IS $5	Wert des aktuellen Knotens
j	IS $6	scaled		* Position des linken / größeren Kindes
kj	IS $7	Wert des linken / größeren Kindes
j1	IS $8	Position rechtes Kind
kj1	IS $9	Wert des rechten Kindes
t	IS $10	Hilfsvariable für Vergleiche

%%%on
:Sort	SLU r,n,3		1 & \ut  H1. Initialize.\\
	SUB r,r,8		1 & $r\is N$.
	SRU l,n,1		1 &	
	SLU l,l,3		1 & $l\is \lfloor N/2\rfloor$.
%%%
	BNP l,9F		1\bg{0} & Terminate if $N<2$.
%%\noalign{\penalty -30}
%%	% l > 0; building the heap
1H	SUB l,l,8		\lfloor N/2\rfloor & $l\is l-1$.
	LDO k,key,l		\lfloor N/2\rfloor & $K\is K_l$.
%%	% replace subtree
	SET j,l	  		\lfloor N/2\rfloor &  \ut  H3. Prepare for siftup.\\ $j\is l$.
	JMP H4	  		\lfloor N/2\rfloor & 
%%%
5H	LDO kj,key,j  		B+A &   $\.kj.\is K_j$.
	BZ t,H6	 		B+A\bg{D} & To H6 if $j = r$.
%%%
	ADD j1,j,8 		B+A-D & \ut  H5. Find larger child.\\ $\.j1.\is j+1$.
	LDO kj1,key,j1 		B+A-D & $\.kj1.\is K_{j+1}$.
	CMP t,kj,kj1 		B+A-D & Compare $K_j:K_{j+1}$.
	CSNP j,t,j1		B+A-D & If $K_j< K_{j+1}$, $j\is j+1$.
	CSNP kj,t,kj1		B+A-D & If $K_j< K_{j+1}$, $\.kj.\is \.kj1.$.
%%%
H6	CMP t,k,kj 		B+A & \ut  H6. Larger than $K$?\\ 
	BNN t,H8 		B+A\bg{A} & To H8 if $K\ge K_j$.	
%%%
	STO kj,key,i 		B &  \ut  H7. Move it up.\\ $R_i\is R_j$. 
%%	% Heapify current subtree
H4	SET i,j			B+P &  \ut  H4. Advance downward.\\ $i\is j$.
	2ADDU j,j,8		B+P & $j\is 2j+1$.^{2ADDU+<2ADDU> (times 2 and add unsigned)}
	CMP t,j,r		B+P & Compare $j:r$.	
	PBNP t,5B		B+P\bg{P-A} & Jump if $j\le r$.		
%%	% k <= kj
H8	STO k,key,i		P &  \ut  H8. Store $R$.\\ $K_i\is K$.
	BP l,1B			P\bg{\lfloor N/2\rfloor-1} &  \ut  H2. Decrease $l$ or $r$.\\ 
%%%
2H	LDO k,key,r		N-1 & If $l=0$, set $K\is K_r$.
	LDO t,key,0		N-1 & 
	STO t,key,r		N-1 & $K_r\is K_1$.
	SUB r,r,8		N-1 & $r\is r-1$.
%%	% if r > 0 -> Heapify
	SET j,0	  		N-1 &  \ut  H3. Prepare for siftup.\\ $j\is l$.
	PBP r,4B 		N-1\bg{1} & To H3 if $r>1$.
%%	% r = 0; done
	STO k,key,0		1 & $K_1\is K$.
%%%	
9H	POP 0,0			  &\slug
%%%off