
[[SET Driver

		LOC	Data_Segment
		GREG	@
Data		[[In]]
		GREG	@
Permute		[[Perm]]
Size		IS	[[n]]	
		GREG	@	
Permuted	[[Out]]

		LOC	#100
Main		LDA	$2,Data
		LDA	$3,Permute
		SET	$4,Size
		GET	$0,:rI	currently not correctly counting cycles
		PUSHJ	$1,reorder
		GET	$1,:rI


		LDA	$1,Data
		LDA	$2,Permuted
		SET	$3,Size
		PUSHJ	$0,:Compare:Octa


		SET	$255,0 
		TRAP 0,Halt,0
Cycles		BYTE	9," cycles:",9,0,0

[[INCLUDE ex11.mms]]

[[INCLUDE compare.mms]]

]]



[[TEST 1]]
[[SET In	OCTA 5,2,0]]
[[SET Perm	OCTA 0,0,0]]
[[SET n  	0]]
[[SET Out 	OCTA 5,2,0]]

[[Driver]]
[[END 1]]


[[TEST 2]]
[[SET In	OCTA 5,2,0]]
[[SET Perm	OCTA 0,0,0]]
[[SET n  	1]]
[[SET Out 	OCTA 5,2,0]]

[[Driver]]
[[END 2]]

[[TEST 3]]
[[SET In	OCTA 5,2,0]]
[[SET Perm	OCTA 0,1,0]]
[[SET n  	2]]
[[SET Out 	OCTA 5,2,0]]

[[Driver]]
[[END 3]]

[[TEST 4]]
[[SET In	OCTA 5,2,0]]
[[SET Perm	OCTA 1,0,0]]
[[SET n  	2]]
[[SET Out 	OCTA 2,5,0]]

[[Driver]]
[[END 4]]

[[TEST 5]]
[[SET In	OCTA "ABCDEFG"]]
[[SET Perm	OCTA 2,4,5,6,1,0,3]]
[[SET n  	7]]
[[SET Out 	OCTA "CEFGBAD"]]

[[Driver]]
[[END 5]]

[[TEST 6]]
[[SET In	OCTA "ABCDEFG"]]
[[SET Perm	OCTA 1,2,3,4,5,6,0]]
[[SET n  	7]]
[[SET Out 	OCTA "BCDEFGA"]]

[[Driver]]
[[END 6]]


[[TEST 7]]
[[SET In	OCTA "ABCDEFG"]]
[[SET Perm	OCTA 6,0,1,2,3,4,5]]
[[SET n  	7]]
[[SET Out 	OCTA "GABCDEF"]]

[[Driver]]
[[END 7]]

[[TEST 8]]
[[SET In	OCTA "ABCDEFG"]]
[[SET Perm	OCTA 2,0,1,6,3,4,5]]
[[SET n  	7]]
[[SET Out 	OCTA "CABGDEF"]]

[[Driver]]
[[END 8]]







