
[[SET Driver

		LOC	Data_Segment
		GREG	@
Data		[[In]]
Size		IS	[[n]]	
		GREG	@	
Sorted		[[Out]]

		LOC	#100
Main		SET	$3,Size
		LDA	$4,Data
		GETA	$5,BSort
		PREGO	255,$5,0
0H		LDO	$5,$4,0		Prime the cache
		ADD	$4,$4,8
		SUB	$3,$3,1
		BP	$3,0B
		
		LDA	$2,Data
		SET	$3,Size
		GET	$0,rI		% get runtime
		PUSHJ	$1,BSort
		GET	$1,rI	        % get runtime again
		[[Runtime]]

		[[INCLUDE OctaEqual.mms Data Sorted Size]] 

		SET	$255,0 
		TRAP 0,Halt,0

[[INCLUDE panny3.mms]]
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

[[SET Runtime	[[INCLUDE runtime.mms $0 $1 863 5 ]]]]

[[Driver]]

[[END 7]]

[[TEST 8]]


[[SET In OCTA  0,1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,8]]
[[SET n  17]]
[[SET Out OCTA 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]]                           

[[Driver]]

[[END 8]]


[[TEST 9]]

[[SET In [[INCLUDE r1000.mms]]]]
[[SET n  1000]]
[[SET Out [[INCLUDE r1000s.mms]]]]

[[SET Runtime	[[INCLUDE runtime.mms $0 $1 250680 5 ]]]]

[[Driver]]

[[END 9]]