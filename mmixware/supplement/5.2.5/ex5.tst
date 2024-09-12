[[SET Driver

		LOC	Data_Segment
		GREG	@
Data		[[In]]
Size		IS	[[n]]
Passes		IS	[[p]]
m		IS	[[m]]	
M		IS	1<<m
		GREG 	@	
Bottom		OCTA	0
		LOC	Bottom+M*8
Top		OCTA	0
		LOC	Top+M*8
		GREG	@
Sorted		[[Out]]

		LOC	#100

Main		SET	$255,1
		LDA	$2,Data
		SET	$3,Size
		SET	$4,Passes
		LDA	$5,Bottom
		GET	$0,rI		% get runtime
		PUSHJ	$1,Sort
		GET	$1,rI	        % get runtime again
		[[Runtime]]
		[[Compare]]
             
		SET	$255,0 
		TRAP 0,Halt,0
[[INCLUDE hook.mms]]
[[INCLUDE empty.mms]]

[[INCLUDE ex5.mms]]
[[INCLUDE print.mms]]

]]

[[SET p 3]]
[[SET m 4]]

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

		LDOU	p,:Bottom
		SET	j,0
		LDA	S,:Sorted
		SET	n,[[n]]
		SL	n,n,3
		JMP	0F


1H		LDO	kp,p,8
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


[[TEST 1]]

	[[SET In  OCTA 0,5,0,0]]
	[[SET n   1]]
	[[SET Out OCTA 5]]
	[[SET p 2]]

	[[Driver]]
[[END 1]]

[[TEST 2]]

[[SET In OCTA  0,5,0,2,0]]
[[SET n  2]]
[[SET p 1]]

[[SET Out OCTA 2,5]]

[[Driver]]
[[END 2]]

[[TEST 3]]

[[SET In OCTA  0,2,0,5,0]]
[[SET n  2]]
[[SET Out OCTA 2,5]]
[[SET p 3]]

[[Driver]]
[[END 3]]

[[TEST 4]]

[[SET In OCTA  0,3,0,2,0,5,0]]
[[SET n  3]]
[[SET p 2]]
[[SET Out OCTA 2,3,5]]

[[Driver]]
[[END 4]]


[[TEST 5]]

[[SET In OCTA  0,5,0,3,0,2,0,5,0]]
[[SET n  4]]
[[SET Out OCTA 2,3,5,5]]
[[SET p 2]]

[[Driver]]
[[END 5]]

[[TEST 6]]


[[SET In OCTA  0,5,0,3,0,2,0,5,0,7,0,11,0,0,0,2,0,99,0,5,0]]
[[SET n  10]]
[[SET p 3]]
[[SET Out OCTA 0,2,2,3,5,5,5,7,11,99]]

[[Driver]]

[[END 6]]

[[COMMENT Table 1 on [[page 81]] and Fig 14 on page 106]]

[[TEST 7]]

[[SET In [[INCLUDE table1l.mms]]]]
[[SET p 3]]
[[SET m 4]]
[[SET n  16]]
[[SET Out [[INCLUDE table1s.mms]]]]

[[SET Runtime	[[INCLUDE runtime.mms $0 $1 1015 5]]]]

[[Driver]]

[[END 7]]


[[TEST 8]]

[[SET In [[INCLUDE s1000l.mms]]]]
[[SET n  1000]]
[[SET p 2]]
[[SET m 8]]
[[SET Out [[INCLUDE s1000s.mms]]]]
[[SET Runtime	[[INCLUDE runtime.mms $0 $1 22693 5]]]]

[[Driver]]

[[END 8]]


[[TEST 9]]

[[SET In [[INCLUDE s10000l.mms]]]]
[[SET n  10000]]
[[SET p 2]]
[[SET m 8]]
[[SET Out [[INCLUDE s10000s.mms]]]]
[[SET Runtime	[[INCLUDE runtime.mms $0 $1 175693 5]]]]

[[Driver]]

[[END 9]]

[[TEST 10]]

[[SET In [[INCLUDE r1000l.mms]]]]
[[SET n  1000]]
[[SET p 4]]
[[SET m 8]]
[[SET Out [[INCLUDE r1000s.mms]]]]
[[SET Runtime	[[INCLUDE runtime.mms $0 $1 44377 5]]]]

[[Driver]]

[[END 10]]

[[TEST 11]]

[[SET In [[INCLUDE r10000l.mms]]]]
[[SET n  10000]]
[[SET p 3]]
[[SET m 11]]
[[SET Out [[INCLUDE r10000s.mms]]]]
[[SET Runtime	[[INCLUDE runtime.mms $0 $1 317671 5]]]]

[[Driver]]

[[END 11]]