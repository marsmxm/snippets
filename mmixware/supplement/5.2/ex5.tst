
[[SET Driver

		LOC	Data_Segment
		GREG	@
Data		[[In]]
Size		IS	[[n]]	
		GREG	@	
Count		OCTA	7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
		LOC	@+Size*8
		GREG	@
Solution	[[Out]]
		GREG	@
Output		OCTA	0
		LOC	Output+Size*8
		GREG	@
Sorted		[[Finish]]

		LOC	#100
Main		LDA	$2,Data
		LDA	$3,Count
		SET	$4,Size
		GET	$0,:rI	
		PUSHJ	$1,Sort
		GET	$1,:rI

		[[Timing]]
		[[CheckCounts]]

		LDA	$2,Data
		LDA	$3,Count
		LDA	$4,Output
		SET	$5,Size


		PUSHJ	$1,Finish

		LDA	$1,Sorted
		LDA	$2,Output
		SET	$3,Size
		PUSHJ	$0,:Compare:Octa

		SET	$255,0 
		TRAP 0,Halt,0


[[INCLUDE ex5.mms]]
[[INCLUDE ex4.mms]]
[[INCLUDE print.mms]]
[[INCLUDE compare.mms]]
]]

[[SET CheckCounts
		LDA	$1,Count
		LDA	$2,Solution
		SET	$3,Size
		PUSHJ	$0,:Compare:Octa
]]


[[SET Timing %]]
[[COMMENT Timing [[INCLUDE runtime.mms $0 $1 0 5]]]]


[[TEST 1]]
[[SET In OCTA 5,2,0]]
[[SET n  1]]
[[SET Out OCTA 8*0,0,0]]
[[SET Finish OCTA 5,0,0]]

[[Driver]]
[[END 1]]

[[TEST 2]]

[[SET In OCTA 5,2,0]]
[[SET n  2]]
[[SET Out OCTA 8*1,8*0,0]]
[[SET Finish OCTA 2,5,0]]

[[Driver]]
[[END 2]]

[[TEST 3]]

[[SET In OCTA 2,5,0]]
[[SET n  2]]
[[SET Out OCTA 8*0,8*1,0]]
[[SET Finish OCTA 2,5,0]]

[[Driver]]
[[END 3]]

[[TEST 4]]

[[SET In OCTA 3,2,5,0]]
[[SET n  3]]
[[SET Out OCTA 8*1,8*0,8*2,0]]
[[SET Finish OCTA 2,3,5,0]]

[[Driver]]
[[END 4]]

[[TEST 5]]

[[SET In OCTA 5,-2,-3,6,0]]
[[SET n  4]]
[[SET Out OCTA 8*2,8*1,8*0,8*3,0]]
[[SET Finish OCTA -3,-2,5,6,0]]

[[Driver]]
[[END 5]]


[[COMMENT Table 1 on page 77 and 81 and Fig 14 on page 106]]
[[TEST 6]]
	[[COMMENT Data for 5.5 table 1]]
	[[SET Timing [[INCLUDE runtime.mms $0 $1 1042 5]]]]
	[[SET In  [[INCLUDE table1.mms]]]]
	[[SET n     16]]
	[[SET Out OCTA 8*6,8*1,8*8,8*0,8*15,8*3,8*14,8*4,8*10,8*5,8*2,8*7,8*9,8*11,8*13,8*12]]
	[[SET Finish  [[INCLUDE table1s.mms]]]]

	[[Driver]]

[[END 6]]

[[TEST 7]]
	[[COMMENT Data for 5.5 table 1]]
	[[SET Timing [[INCLUDE runtime.mms $0 $1 4046134 5]]]]
	[[SET In  [[INCLUDE r1000.mms]]]]
	[[SET n     1000]]
	[[SET CheckCounts %]]
	[[SET Out OCTA 0]]	
	[[SET Finish  [[INCLUDE r1000s.mms]]]]

	[[Driver]]

[[END 7]]
