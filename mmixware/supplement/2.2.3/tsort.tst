[[SET Driver


[[INCLUDE tsort.mms]]


Main		PUSHJ	$0,TSort
		
		[[INCLUDE TetraEqual.mms :TSort:Buffer :TSort:Sorted [[n]]]]

		SET	$255,0
		TRAP	0,Halt,0


]]


[[TEST 1]]
[[SET n 3]]
[[SET Data	TETRA	0,[[n]],1,2,1,3,0,0]]
[[SET Sorted	TETRA	1,3,2,0]]
[[Driver]]
[[END 1]]



[[TEST 2]]
[[SET n 9]]
[[SET Data	TETRA	0,[[n]],9,2,3,7,7,5,5,8,8,6,4,6,1,3,7,4,9,5,2,8,0,0]]
[[SET Sorted	TETRA	9,1,2,3,7,4,5,8,6,0]]
[[Driver]]
[[END 2]]
