
[[COMMENT for progs2 Program 5.2.4S]]

[[SET Driver
                LOC	Data_Segment
		GREG	@
Data		[[In]]
Size		IS	[[n]]
		GREG	@
Data2		IS	@
		LOC	Data2+8*Size
		GREG	@
Out		OCTA	0
Sorted		[[Out]]
		
		LOC	#100
Main		LDA	$3,Data
		LDA	$4,Data2
		SET	$5,Size
		GET	$0,rI		% get runtime
		PUSHJ	$2,Sort
		GET	$1,rI	        % get runtime again
		STOU	$2,Out
		[[Runtime]]

		LDOU	$0,Out
		[[INCLUDE OctaEqual.mms $0 Sorted Size]] 

		SET	$255,0 
		TRAP 0,Halt,0
		
		GREG	@

[[INCLUDE progs2.mms]]
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


[[SET Runtime	[[INCLUDE runtime.mms $0 $1 [[time]] 5]]]]


[[COMMENT Table 1 on page 140]]
[[TEST 7]]
	[[SET In [[INCLUDE table1.mms]]]]
	[[SET n  16]]
	[[SET Out [[INCLUDE table1s.mms]]]]
	[[SET time 803]]
	[[Driver]]
[[END 7]]


[[COMMENT 1000 Elemente]]
[[TEST 10]]
	[[SET In [[INCLUDE r1000.mms]]]]
	[[SET n 1000]]
	[[SET Out [[INCLUDE r1000s.mms]]]]
	[[SET time  92548]]
	[[Driver]]
[[END 10]]
