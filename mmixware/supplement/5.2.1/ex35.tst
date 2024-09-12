[[SET Driver

		LOC	Data_Segment
d		IS	[[d]]
e		IS	[[e]]
Size		IS	[[n]]	
M		IS	1<<d
		GREG	@
R0		OCTA	0,0
Data		[[In]]
		GREG @	
Heads		OCTA	0
		LOC	Heads+8*M
		GREG	@
Sorted		[[Out]]

		LOC	#100
Main		LDA	$2,R0
		SET	$3,Size
		LDA	$4,Heads
		PUSHJ	$1,Sort

		LDA	$4,Heads
		SET	$5,M
		LDA	$6,R0
		GET	$0,rI		% get runtime
		PUSHJ	$3,ListCat
		GET	$1,rI	        % get runtime again

		[[Runtime]]

		LDA	$1,:Heads
		LDA	$2,:R0
		LDA	$3,:Sorted
		SET	$4,:Size		% now just one list
		PUSHJ	$0,:LEqual	
  
		SET	$255,0 
		TRAP 0,Halt,0

[[INCLUDE ex35.mms]]
[[INCLUDE mlistishift.mms]]
[[INCLUDE print.mms]]

		PREFIX	:LEqual:
head	IS	$0
link	IS	$1
S	IS	$2
n	IS	$3

p	IS	$4
kp	IS	$5
k	IS	$6
t	IS	$7
j	IS	$8
key	IS	$9

:LEqual		ADD	key,link,8
		LDOU	p,head,0
		SET	j,0
		SET	n,[[n]]
		SL	n,n,3
		JMP	0F


1H		LDO	kp,key,p
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
		POP	0,0

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
[[SET In [[INCLUDE table1l.mms]]]]
[[SET n  16]]
[[SET Out [[INCLUDE table1s.mms]]]]

[[COMMENT the runtime should be 78 oops and 22 mems]]

[[SET Runtime	[[INCLUDE runtime.mms $0 $1 78 5 ]]]]

[[Driver]]

[[END 7]]

[[TEST 8]]


[[SET In [[INCLUDE r1000l.mms]]]]
[[SET n  1000]]
[[SET d 7]]
[[SET e 32]]
[[SET Out [[INCLUDE r1000s.mms]]]]

[[COMMENT the runtime should be 79 oops and 22 mems]]

[[SET Runtime	[[INCLUDE runtime.mms $0 $1 4107 5 ]]]]

[[Driver]]

[[END 8]]
