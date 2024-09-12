
[[SET Driver

		LOC	Data_Segment
		GREG	@
Data		[[In]]
Size		IS	[[n]]		
Sorted		[[Out]]

		LOC	#100
Main		LDA	$1,Data
		SET	$2,Size
		PUSHJ	$0,Sort

		[[INCLUDE ByteEqual.mms Data Sorted Size]] 

		SET	$255,0 
		TRAP 0,Halt,0

[[INCLUDE short.mms]]

]]

[[TEST 1]]
	[[SET In  BYTE 5,0]]
	[[SET n     1]]
	[[SET Out BYTE 5,0]]

	[[Driver]]
[[END 1]]

[[TEST 2]]

[[SET In BYTE 5,2,0]]
[[SET n  2]]
[[SET Out BYTE 2,5,0]]

[[Driver]]
[[END 2]]

[[TEST 3]]

[[SET In BYTE 2,5,0]]
[[SET n  2]]
[[SET Out BYTE 2,5,0]]

[[Driver]]
[[END 3]]

[[TEST 4]]

[[SET In BYTE 3,2,5,0]]
[[SET n  3]]
[[SET Out BYTE 2,3,5,0]]

[[Driver]]
[[END 4]]

[[TEST 5]]

[[SET In BYTE 5,3,2,5,0]]
[[SET n  4]]
[[SET Out BYTE 2,3,5,5,0]]

[[Driver]]
[[END 5]]

[[TEST 6]]


[[SET In BYTE 5,3,2,5,7,11,1,2,99,5,0]]
[[SET n  10]]
[[SET Out BYTE 1,2,2,3,5,5,5,7,11,99,0]]

[[Driver]]

[[END 6]]

[[COMMENT Table 1 on page 81 and Fig 14 on page 106
[[TEST 7]]


[[SET In [[INCLUDE table1.mms]]]]
[[SET n  16]]
[[SET Out [[INCLUDE table1s.mms]]]]

[[Driver]]

[[END 7]]
]]

[[COMMENT using -6 as a BYTE value]]
[[TEST 8]]
	[[SET In  BYTE #FA,0]]
	[[SET n     1]]
	[[SET Out BYTE #FA,0]]

	[[Driver]]
[[END 8]]
