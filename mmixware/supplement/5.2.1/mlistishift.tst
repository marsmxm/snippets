[[SET Driver

		LOC	Data_Segment
d		IS	[[d]]
e		IS	[[e]]
Size		IS	[[n]]
M		IS	(1<<d)	
		GREG 	@	
R0		OCTA 	0,0
Data		[[In]]
		GREG	@	
Heads		OCTA	0
		LOC	Heads+8*M
		GREG	@
Sorted		[[Out]]

		LOC	#100
Main		LDA	$2,R0
		SET	$3,Size
		LDA	$4,Heads
		GET	$0,rI		% get runtime
		PUSHJ	$1,Sort
		GET	$1,rI	        % get runtime again

		[[Runtime]]

		LDA	$1,:Heads
		SET	$2,:M
		LDA	$3,:Sorted
		SET	$4,:Size
		PUSHJ	$0,:List:Equal	
             
		SET	$255,0 
		TRAP 0,Halt,0

[[INCLUDE mlistishift.mms]]
[[INCLUDE print.mms]]

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
key	IS	$9
link	IS	$10

Equal		SET	j,0
		SL	n,n,3
		SET	p,0
		LDA	link,:R0
		LDA	key,:R0+8
		JMP	0F


1H		BNZ	p,4F
		LDO	p,H,0
		SUB	m,m,1
		BN	m,3F
		ADD	H,H,8
		JMP	1B
4H		LDO	kp,key,p
		LDO	k,S,j
		CMP	t,k,kp
		BZ	t,2F
3H		SET	$255,1 
		TRAP 	0,:Halt,0
2H		LDOU	p,link,p
		ADD	j,j,8
0H		CMP	t,j,n
		BN	t,1B
		BNZ	p,3B


		PREFIX	:

]]

[[SET Runtime %]]

[[SET d 2]]
[[SET e 10]]


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
[[SET d 2]]
[[SET e 10]]
[[SET In  [[INCLUDE table1l.mms]]]]
[[SET n  16]]
[[SET Out [[INCLUDE table1s.mms]]]]


[[COMMENT Used in 5.5 table 1]]
[[SET Runtime	[[INCLUDE runtime.mms $0 $1 286 5 ]]]]

[[Driver]]

[[END 7]]

[[TEST 8]]

[[SET d 7]]
[[SET e 32]]
[[SET In  [[INCLUDE r1000l.mms]]]]
[[SET n  1000]]
[[SET Out [[INCLUDE r1000s.mms]]]]


[[COMMENT Used in 5.5 table 1]]
[[SET Runtime	[[INCLUDE runtime.mms $0 $1 26092 5 ]]]]

[[Driver]]

[[END 8]]

[[TEST 9]]

[[SET d 7]]
[[SET e 32]]
[[SET In  [[INCLUDE r10000l.mms]]]]
[[SET n  10000]]
[[SET Out [[INCLUDE r10000s.mms]]]]


[[COMMENT Used in 5.5 table 1]]
[[SET Runtime	[[INCLUDE runtime.mms $0 $1 1310692 5 ]]]]

[[Driver]]

[[END 9]]

[[TEST 10]]

[[SET d 7]]
[[SET e 16]]
[[SET In  [[INCLUDE s64l.mms]]]]
[[SET n  64]]
[[SET Out [[INCLUDE s64s.mms]]]]


[[COMMENT Used in 5.5 table 1]]
[[SET Runtime	[[INCLUDE runtime.mms $0 $1 1258 5 ]]]]

[[Driver]]

[[END 10]]


[[TEST 12]]

[[SET d 7]]
[[SET e 32]]
[[SET In  [[INCLUDE r2000l.mms]]]]
[[SET n  2000]]
[[SET Out [[INCLUDE r2000s.mms]]]]


[[COMMENT Used in 5.5 table 1]]
[[SET Runtime	[[INCLUDE runtime.mms $0 $1 75754 5 ]]]]

[[Driver]]

[[END 12]]
