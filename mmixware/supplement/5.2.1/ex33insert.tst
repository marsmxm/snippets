
[[SET Driver

		LOC	Data_Segment
		GREG	@
		OCTA	#8000000000000000	-infinity
Data		[[In]]
		OCTA	#7fffffffffffffff	+infinity
Size		IS	[[n]]		
		GREG	@
Sorted		[[Out]]

		LOC	#100
Main		LDA	$2,Data
		SET	$3,Size
		GET	$0,rI		% get runtime
		PUSHJ	$1,Sort
		GET	$1,rI	        % get runtime again

		[[Runtime]]
		[[INCLUDE OctaEqual.mms Data Sorted Size]] 
                
		SET	$255,0 
		TRAP 0,Halt,0

[[INCLUDE ex33insert.mms]]
[[INCLUDE print.mms]]

]]

[[SET Runtime SWYM]]

[[TEST 1]]
	[[SET In  OCTA 5]]
	[[SET n     1]]
	[[SET Out OCTA 5]]

	[[Driver]]
[[END 1]]

[[TEST 2]]

[[SET In OCTA 5,2]]
[[SET n  2]]
[[SET Out OCTA 2,5]]

[[Driver]]
[[END 2]]

[[TEST 3]]

[[SET In OCTA 2,5]]
[[SET n  2]]
[[SET Out OCTA 2,5]]

[[Driver]]
[[END 3]]

[[TEST 4]]

[[SET In OCTA 3,2,5]]
[[SET n  3]]
[[SET Out OCTA 2,3,5]]

[[Driver]]
[[END 4]]

[[TEST 5]]

[[SET In OCTA 5,3,2,5]]
[[SET n  4]]
[[SET Out OCTA 2,3,5,5]]

[[Driver]]
[[END 5]]

[[TEST 6]]


[[SET In OCTA 5,3,2,5,7,11,-3,2,99,5]]
[[SET n  10]]
[[SET Out OCTA -3,2,2,3,5,5,5,7,11,99]]

[[Driver]]

[[END 6]]

[[COMMENT Table 1 on [[page 81]] and Fig 14 on page 106]]
[[TEST 7]]


[[SET In [[INCLUDE table1.mms]]]]
[[SET n  16]]
[[SET Out [[INCLUDE table1s.mms]]]]
	[[COMMENT Data for 5.5 table 1]]
[[SET Runtime	[[INCLUDE runtime.mms $0 $1 377 5 ]]]]

[[Driver]]

[[END 7]]

[[TEST 8]]


[[SET In [[INCLUDE r1000.mms]]]]
[[SET n  1000]]
[[SET Out [[INCLUDE r1000s.mms]]]]
	[[COMMENT Data for 5.5 table 1]]
[[SET Runtime	[[INCLUDE runtime.mms $0 $1 1291521 5 ]]]]

[[Driver]]

[[END 8]]
