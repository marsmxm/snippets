[[SET Driver

		LOC	Data_Segment
		GREG	@
Head		OCTA	0,0		the artificial R_0 record with its link field
Data		[[In]]
Size		IS	[[n]]	
		GREG @	

Sorted		[[Out]]

before		IS	$0
after		IS	$1
t		IS	$2
		LOC	#100
Main		LDA	t+1,Head
		SET	t+2,Size
		GET	before,rI		% get runtime
		PUSHJ	t,Sort
		GET	after,rI	        % get runtime again
		[[Runtime]]
		[[Compare]]
             
		SET	$255,0 
		TRAP 0,Halt,0

[[INCLUDE listi.mms]]
[[INCLUDE print.mms]]

]]

[[SET Runtime %]]

[[SET Compare	
		PREFIX	:LEqual:
p	IS	$2
kp	IS	$3
k	IS	$5
t	IS	$6
j	IS	$7
S	IS	$8
n	IS	$9
K	IS	$10
L	IS	$11

		LDA	L,:Head
		LDA	K,:Head+8
		LDOU	p,L,0
		SET	j,0
		LDA	S,:Sorted
		SET	n,[[n]]
		SL	n,n,3
		JMP	0F


1H		LDO	kp,K,p
		LDO	k,S,j
		CMP	t,k,kp
		BZ	t,2F
3H		SET	$255,1 
		TRAP 	0,:Halt,0
2H		LDOU	p,L,p
		ADD	j,j,8
0H		CMP	t,j,n
		BN	t,1B
		BNZ	p,3B


		PREFIX	:
]]


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


[[SET In OCTA  0,5,0,3,0,2,0,5,0,7,0,11,0,-3,0,2,0,99,0,5,0]]
[[SET n  10]]
[[SET Out OCTA -3,2,2,3,5,5,5,7,11,99]]

[[Driver]]

[[END 6]]

[[COMMENT Table 1 on [[page 81]] and Fig 14 on page 106]]
[[TEST 7]]


[[SET In   [[INCLUDE table1l.mms]]]]
[[SET n  16]]
[[SET Out [[INCLUDE table1s.mms]]]]



[[SET Runtime	[[INCLUDE runtime.mms :before :after 426 5 ]]]]


[[Driver]]

[[END 7]]

[[COMMENT Table 1 on [[page 81]] and Fig 14 on page 106]]
[[TEST 8]]


[[SET In    [[INCLUDE r1000l.mms]]]]
[[SET n  1000]]
[[SET Out [[INCLUDE r1000s.mms]]]]



[[SET Runtime	[[INCLUDE runtime.mms :before :after 1548603 5 ]]]]


[[Driver]]

[[END 8]]
