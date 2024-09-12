
[[SET Driver

		LOC	Data_Segment
		GREG	@
Data		[[In]]
Size		IS	[[n]]	
		GREG 	@	
Sorted		[[Out]]
		GREG	@
oops		OCTA	[[oops]]
H		[[H]]


		LOC	#100
Main		LDA	$2,Data
		SET	$3,Size
		LDA	$4,H
		SET	$5,[[t]]
		GET	$0,rI		% get runtime
		PUSHJ	$1,Sort
		GET	$1,rI	        % get runtime again
		[[Runtime]]

		[[INCLUDE OctaEqual.mms Data Sorted Size]] 
                
		SET	$255,0 
		TRAP 0,Halt,0

[[INCLUDE ex31imp.mms]]
[[INCLUDE print.mms]]

]]

[[SET Runtime %]]
[[SET H OCTA 1,2,3,4,6,8,9,12]]
[[SET t 1]]
[[SET oops 0]]

[[TEST 1]]

	[[SET In  OCTA 5,0]]
	[[SET n   1]]
	[[SET t	  1]]
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
[[SET t 2]]
[[SET Out OCTA 2,3,5,0]]

[[Driver]]
[[END 4]]

[[TEST 5]]

[[SET In OCTA 5,3,2,5,0]]
[[SET n  4]]
[[SET t	 3]]
[[SET Out OCTA 2,3,5,5,0]]

[[Driver]]
[[END 5]]

[[TEST 6]]


[[SET In OCTA 5,3,2,5,7,11,-3,2,99,5,0]]
[[SET n  10]]
[[SET t	 7]]
[[SET Out OCTA -3,2,2,3,5,5,5,7,11,99,0]]

[[Driver]]

[[END 6]]

[[COMMENT Table 1 on [[page 81]] and Fig 14 on page 106]]
[[SET In OCTA  503,087,512,061,908,170,897,275,653,426,154,509,612,677,765,703]]
[[SET Out OCTA 061,087,154,170,275,426,503,509,512,612,653,677,703,765,897,908]]
[[SET n  16]]
[[SET t	 8]]

[[TEST 7]]

[[COMMENT the runtime should be 916 oops and 192 mems]]
[[SET Runtime	[[INCLUDE runtime.mms $0 $1 916 5 ]]]]
[[Driver]]

[[END 7]]

[[TEST 8]]
[[SET In [[INCLUDE r1000.mms]]]]
[[SET n 1000]]
[[SET Out [[INCLUDE r1000s.mms]]]]
[[SET H [[INCLUDE pratt1000.inc]]]]
[[SET t 40]]
[[SET Runtime	[[INCLUDE runtime.mms $0 $1 228748 5 ]]]]

[[Driver]]
[[END 8]]