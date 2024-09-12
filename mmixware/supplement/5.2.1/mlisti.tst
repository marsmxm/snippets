[[SET Driver

		LOC	Data_Segment
M		IS	[[M]]
e		IS	[[e]]
Size		IS	[[n]]	
		GREG 	@
R0		OCTA	0,0	artificial first record
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
		SET	$5,M
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

[[INCLUDE mlisti.mms]]
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

[[SET M 4]]
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

[[SET M 4]]

[[SET In  [[INCLUDE table1l.mms]]]]
[[SET n  16]]
[[SET Out [[INCLUDE table1s.mms]]]]

[[COMMENT the runtime should be 446 oops and 91 mems]]

[[SET Runtime	[[INCLUDE runtime.mms $0 $1 446 5 ]]]]

[[Driver]]

[[END 7]]

[[TEST 8]]

[[SET M 10]]

[[SET In  [[INCLUDE table1l.mms]]]]
[[SET n  16]]
[[SET Out [[INCLUDE table1s.mms]]]]

[[COMMENT the runtime should be 462 oops and 91 mems]]

[[SET Runtime	[[INCLUDE runtime.mms $0 $1 434 5 ]]]]

[[Driver]]

[[END 8]]

[[TEST 9]]
[[SET M 100]]
[[SET e 16]]

[[SET In  [[INCLUDE s1000l.mms]]]]
[[SET n  1000]]
[[SET Out [[INCLUDE s1000s.mms]]]]

[[SET Runtime	[[INCLUDE runtime.mms $0 $1 39221 5 ]]]]

[[Driver]]

[[END 9]]
