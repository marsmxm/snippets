[[SET Driver

		LOC	Data_Segment
		GREG	@
Data		[[In]]
Size		IS	[[n]]	
		GREG @	
M		IS	[[M]]
Heads		OCTA	0
		LOC	Heads+8*M
Tails		OCTA	0
		LOC	Tails+8*M
Sorted		[[Out]]

		LOC	#100
Main		LDA	$2,Data
		SET	$3,Size
		LDA	$4,Heads
		SET	$5,M
		LDA	$6,Tails
		PUSHJ	$1,ListMsort

		LDA	$2,Heads
		LDA	$3,Tails
		SET	$4,M
		GET	$0,rI		% get runtime
		PUSHJ	$1,ListCat
		GET	$1,rI	        % get runtime again

		[[Runtime]]

		LDA	$1,:Heads
		SET	$2,1
		LDA	$3,:Sorted
		SET	$4,:Size
		PUSHJ	$0,:List:Equal	
             
		SET	$255,0 
		TRAP 0,Halt,0

[[INCLUDE ex35mlisti.mms]]
[[INCLUDE print.mms]]

		PREFIX	:ListCat:
H	IS	$0	Parameter
T	IS	$1
m	IS	$2

j	IS	$3	Local variables
p	IS	$4
q	IS	$5
head	IS	$6
tail	IS	$7

:ListCat	IS	@
		BZ	m,9F
--->>>
ListCat		SL	j,m,3		\hfil$1$ 
		SUB	j,j,8		\hfil$1$ 
		LDOU	head,H,j	\hfil$1$ 	& Initialize \.{tail}.
		JMP	0F		\hfil$1$ 	& Loop on $j$.
<<<--- --->>>
1H		LDOU	tail,T,j	\hfil$M-1$ 
		BZ	tail,0F		\hfil$M-1+2E$ 	& Skip empty heads. 
<<<--- --->>>
		STOU	head,tail		\hfil$M-1-E$ 	& Concatenate lists.
		LDOU	head,H,j	\hfil$M-1-E$	&  Advance to the next list.
0H		SUB	j,j,8		\hfil$M$ 	&
		PBNN	j,1B		\hfil$M$ 	&$0\le j < m-1$
		STOU	head,H,0	\hfil$1$ 
		POP	0,0
<<<---
9H		POP	0,0

		PREFIX	:
--->>>

		PREFIX	:List:
H	IS	$0	Heads Parameter
m	IS	$1	Number of heads
S	IS	$2	Sorted keys
n	IS	$3	Number of keys

kp	IS	$4	Local variables
p	IS	$5
k	IS	$6
t	IS	$7
j	IS	$8

Equal		SET	j,0
		SL	n,n,3
		SET	p,0
		JMP	0F


1H		BNZ	p,4F
		LDO	p,H,0
		SUB	m,m,1
		BN	m,3F
		ADD	H,H,8
		JMP	1B
4H		LDO	kp,p,8
		LDO	k,S,j
		CMP	t,k,kp
		BZ	t,2F
3H		SET	$255,1 
		TRAP 	0,:Halt,0
2H		LDOU	p,p,0
		ADD	j,j,8
0H		CMP	t,j,n
		BN	t,1B
		BNZ	p,3B


		PREFIX	:

]]

[[SET Runtime %]]

[[SET M 4]]

[[TEST 1]]

	[[SET In  OCTA 0,5,0,0]]
	[[SET n   1]]
	[[SET Out OCTA 5]]

	[[Driver]]
[[END 1]]

[[TEST 2]]

[[SET In OCTA  0,5,0,2,0]]
[[SET n  2]]
[[SET Out OCTA 2,5]]

[[Driver]]
[[END 2]]

[[TEST 3]]

[[SET In OCTA  0,2,0,5,0]]
[[SET n  2]]
[[SET Out OCTA 2,5]]

[[Driver]]
[[END 3]]

[[TEST 4]]

[[SET In OCTA  0,3,0,2,0,5,0]]
[[SET n  3]]
[[SET Out OCTA 2,3,5]]

[[Driver]]
[[END 4]]


[[TEST 5]]

[[SET In OCTA  0,5,0,3,0,2,0,5,0]]
[[SET n  4]]
[[SET Out OCTA 2,3,5,5]]

[[Driver]]
[[END 5]]

[[TEST 6]]


[[SET In OCTA  0,5,0,3,0,2,0,5,0,7,0,11,0,0,0,2,0,99,0,5,0]]
[[SET n  10]]
[[SET Out OCTA 0,2,2,3,5,5,5,7,11,99]]

[[Driver]]

[[END 6]]

[[COMMENT Table 1 on [[page 81]] and Fig 14 on page 106]]
[[TEST 7]]


[[SET In [[INCLUDE table1l.mms]]]]
[[SET n  16]]
[[SET Out [[INCLUDE table1s.mms]]]]

[[COMMENT the runtime should be 462 oops and 91 mems]]

[[SET Runtime	[[INCLUDE runtime.mms $0 $1 28 5 ]]]]
[[SET Compare
		LDO	$1,:Heads
		LDA	$2,Sorted
		SET	$3,4
		PUSHJ	$0,:List:Equal	
		LDO	$1,:Heads+8
		LDA	$2,Sorted+4*8
		SET	$3,4
		PUSHJ	$0,:List:Equal	
		LDO	$1,:Heads+16
		LDA	$2,Sorted+8*8
		SET	$3,6
		PUSHJ	$0,:List:Equal	
		LDO	$1,:Heads+24
		LDA	$2,Sorted+14*8
		SET	$3,2
		PUSHJ	$0,:List:Equal	
]]

[[Driver]]

[[END 7]]
