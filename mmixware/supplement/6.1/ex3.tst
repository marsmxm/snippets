
[[SET Driver

		LOC	Data_Segment
		GREG	@
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



[[INCLUDE ex3.mms]]

]]

[[SET IsNull  BNZ	$0,Error]]
[[SET IsValue 
	LDO 	$1,$0,8
	SET	$2,[[1]]
	CMP	$3,$1,$2
	BNZ	$3,Error]]
	


[[TEST 2]]
	[[SET In  OCTA 0,5]]
	[[SET Key   7]]
	[[SET Test [[IsNull]]]]
	
	[[Driver]]
[[END 2]]

[[TEST 3]]
	[[SET In  OCTA 0,5]]
	[[SET Key   5]]
	[[SET Test [[IsValue [[Key]]]]]]
	
	[[Driver]]
[[END 3]]

[[TEST 4]]
	[[SET In  OCTA 1F,5
1H	          OCTA 0,8]]
	[[SET Key   5]]
	[[SET Test [[IsValue [[Key]]]]]]
	
	[[Driver]]
[[END 4]]

[[TEST 5]]
	[[SET In  OCTA 1F,5
1H	          OCTA 0,8]]
	[[SET Key   8]]
	[[SET Test [[IsValue [[Key]]]]]]
	
	[[Driver]]
[[END 5]]

[[TEST 6]]
	[[SET In  OCTA 1F,5
1H	          OCTA 0,8]]
	[[SET Key   4]]
	[[SET Test [[IsNull]]]]
	[[Driver]]
[[END 6]]

[[TEST 7]]
	[[SET In  OCTA 1F,5
1H	          OCTA 0,8]]
	[[SET Key   6]]
	[[SET Test [[IsNull]]]]
	[[Driver]]
[[END 7]]

[[TEST 8]]
	[[SET In  OCTA 1F,5
1H	          OCTA 0,8]]
	[[SET Key   9]]
	[[SET Test [[IsNull]]]]
	[[Driver]]
[[END 8]]



[[TEST 9]]
	[[SET In  OCTA 1F,5
1H	          OCTA 1F,8
1H	          OCTA 0,10]]
	[[SET Key   5]]
	[[SET Test [[IsValue [[Key]]]]]]
	
	[[Driver]]
[[END 9]]

[[TEST 10]]
	[[SET In  OCTA 1F,5
1H	          OCTA 1F,8
1H	          OCTA 0,10]]
	[[SET Key   8]]
	[[SET Test [[IsValue [[Key]]]]]]
	
	[[Driver]]
[[END 10]]

[[TEST 11]]
	[[SET In  OCTA 1F,5
1H	          OCTA 1F,8
1H	          OCTA 0,10]]
	[[SET Key   10]]
	[[SET Test [[IsValue [[Key]]]]]]
	
	[[Driver]]
[[END 11]]

[[TEST 12]]
	[[SET In  OCTA 1F,5
1H	          OCTA 1F,8
1H	          OCTA 0,10]]
	[[SET Key   4]]
	[[SET Test [[IsNull]]]]
	[[Driver]]
[[END 12]]

[[TEST 13]]
	[[SET In  OCTA 1F,5
1H	          OCTA 1F,8
1H	          OCTA 0,10]]
	[[SET Key   6]]
	[[SET Test [[IsNull]]]]
	[[Driver]]
[[END 13]]

[[TEST 14]]
	[[SET In  OCTA 1F,5
1H	          OCTA 1F,8
1H	          OCTA 0,10]]
	[[SET Key   9]]
	[[SET Test [[IsNull]]]]
	[[Driver]]
[[END 14]]

[[TEST 15]]
	[[SET In  OCTA 1F,5
1H	          OCTA 1F,8
1H	          OCTA 0,10]]
	[[SET Key   11]]
	[[SET Test [[IsNull]]]]
	[[Driver]]
[[END 15]]

