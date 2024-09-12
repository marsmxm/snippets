
[[SET Driver

		LOC	Data_Segment
		GREG	@
Data		[[In]]
Size		IS	[[n]]
		GREG	@		
Sorted		[[Out]]

		LOC	#100
Main		LDA	$2,Data
		SET	$3,Size
		GET	$0,rI
		PUSHJ	$1,Sort
		GET	$1,rI
		
		[[Runtime]]

		[[INCLUDE OctaEqual.mms Data Sorted Size]] 

		SET	$255,0 
		TRAP 0,Halt,0

[[INCLUDE bubble.mms]]

[[INCLUDE print.mms]]
]]

[[SET Runtime %]]

[[TEST 1]]
	[[SET In  OCTA 5,0]]
	[[SET n     1]]
	[[SET Out OCTA 5,0]]

	[[Driver]]
[[END 1]]

[[TEST 2]]

[[SET In OCTA 5,2,0]]
[[SET n  2]]
[[SET Out OCTA 2,5,0]]

[[Driver]]
[[END 2]]

[[TEST 3]]

[[SET In OCTA 2,5,0]]
[[SET n  2]]
[[SET Out OCTA 2,5,0]]

[[Driver]]
[[END 3]]

[[TEST 4]]

[[SET In OCTA 3,2,5,0]]
[[SET n  3]]
[[SET Out OCTA 2,3,5,0]]

[[Driver]]
[[END 4]]

[[TEST 5]]

[[SET In OCTA 5,3,2,5,0]]
[[SET n  4]]
[[SET Out OCTA 2,3,5,5,0]]

[[Driver]]
[[END 5]]

[[TEST 6]]


[[SET In OCTA 5,3,2,5,7,11,-3,2,99,5,0]]
[[SET n  10]]
[[SET Out OCTA -3,2,2,3,5,5,5,7,11,99,0]]

[[Driver]]

[[END 6]]

[[TEST 7]]


[[SET In [[INCLUDE table1.mms]]]]
[[SET n  16]]
[[SET Out [[INCLUDE table1s.mms]]]]
[[SET Runtime [[INCLUDE runtime.mms $0 $1 676 5 ]]]]
[[Driver]]

[[END 7]]


[[TEST 8]]

[[SET In OCTA  5,3,2,5,7,11,-3,2,99,5,0,2,2,2,3,3,4]]
[[SET n  17]]
[[SET Out OCTA -3,0,2,2,2,2,2,3,3,3,4,5,5,5,7,11,99]]

[[Driver]]

[[END 8]]



[[TEST 9]]

[[SET In [[INCLUDE r1000.mms]]]]
[[SET n  1000]]
[[SET Out [[INCLUDE r1000s.mms]]]]

[[SET Runtime	[[INCLUDE runtime.mms $0 $1 3973364 5 ]]]]

[[Driver]]

[[END 9]]

[[COMMENT  This test works but takes a loooong time
[[TEST 99]]

[[SET In [[INCLUDE r10000.mms]]]]
[[SET n  10000]]
[[SET Out [[INCLUDE r10000s.mms]]]]

[[SET Runtime	[[INCLUDE runtime.mms $0 $1 399949036 5 ]]]]

[[Driver]]

[[END 99]]

]]