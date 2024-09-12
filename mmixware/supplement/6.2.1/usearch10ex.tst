
[[SET Driver

		LOC	Data_Segment
		GREG	@
		OCTA	#8000000000000000	MIN OCTA
Data		[[In]]
Key		IS	[[Key]]

		LOC	#100
Main		LDA	$1,Data
		SET	$2,Key
		PUSHJ	$0,Search

		[[Test]]

OK		SET	$255,0 
		TRAP 0,Halt,0

Error		SET	$255,1 
		TRAP 0,Halt,0



[[INCLUDE usearch10ex.mms]]

]]

[[SET IsNull  BNZ	$0,Error]]
[[SET IsValue 
	LDO 	$1,$0,0
	SET	$2,[[1]]
	CMP	$3,$1,$2
	BNZ	$3,Error]]
	

[[COMMENT Example 5.2.1 page 411]]
[[TEST 1]]
	[[SET In  OCTA 061,087,154,170,275,462,505,509,512,612,653,677,703,765,897,908]]
	[[SET Key   612]]
	[[SET Test [[IsValue [[Key]]]]]]
	
	[[Driver]]
[[END 1]]

[[TEST 2]]
	[[SET In  OCTA 061,087,154,170,275,462,505,509,512,612,653,677,703,765,897,908]]
	[[SET Key   61]]
	[[SET Test [[IsValue [[Key]]]]]]
	[[Driver]]
[[END 2]]



[[TEST 3]]
	[[SET In  OCTA 061,087,154,170,275,462,505,509,512,612,653,677,703,765,897,908]]
	[[SET Key   050]]
	[[SET Test [[IsNull]]]]
	
	[[Driver]]
[[END 3]]

[[TEST 4]]
	[[SET In  OCTA 061,087,154,170,275,462,505,509,512,612,653,677,703,765,897,908]]
	[[SET Key   653]]
	[[SET Test [[IsNull]]]]
	
	[[Driver]]
[[END 4]]

[[TEST 5]]
	[[SET In  OCTA 061,087,154,170,275,462,505,509,512,612,653,677,703,765,897,908]]
	[[SET Key   170]]
	[[SET Test [[IsValue [[Key]]]]]]
	[[Driver]]
[[END 5]]

[[TEST 6]]
	[[SET In  OCTA 061,087,154,170,275,462,505,509,512,612,653,677,703,765,897,908]]
	[[SET Key   505]]
	[[SET Test [[IsValue [[Key]]]]]]
	[[Driver]]
[[END 6]]

[[TEST 7]]
	[[SET In  OCTA 061,087,154,170,275,462,505,509,512,612,653,677,703,765,897,908]]
	[[SET Key   507]]
	[[SET Test [[IsNull]]]]
	
	[[Driver]]
[[END 7]]
