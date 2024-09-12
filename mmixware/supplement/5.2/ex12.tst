[[SET Driver

		LOC	Data_Segment
		GREG	@
Head		OCTA	0,0
Data		[[In]]
Size		IS	[[n]]	
		GREG @	

Sorted		[[Out]]

		LOC	#100
Main		LDA	$2,Head
		SET	$3,Size
		PUSHJ	$1,Sort
		LDA	$2,Head
		GET	$0,rI		% get runtime
		PUSHJ	$1,MacLaren:M1
		GET	$1,rI	        % get runtime again
		[[Runtime]]
		[[Compare]]
             
		SET	$255,0 
		TRAP 0,Halt,0

[[INCLUDE ../5.2.1/listi.mms]]
[[INCLUDE ex12.mms]]
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

		LDA	p,:Data
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
2H		ADDU	p,p,16
		ADD	j,j,8
0H		CMP	t,j,n
		BN	t,1B



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


[[SET In OCTA   0,503,0,087,0,512,0,061,0,908,0,170,0,897,0,275,0,653,0,426,0,154,0,509,0,612,0,677,0,765,0,703,0]]
[[SET n  16]]
[[SET Out [[INCLUDE table1s.mms]]]]


[[SET Runtime	[[INCLUDE runtime.mms $0 $1 280 5]]]]


[[Driver]]

[[END 7]]
