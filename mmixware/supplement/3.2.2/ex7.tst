[[SET Driver


	LOC	#100


x	GREG	[[X]]

a	GREG	[[a]]



	PREFIX	:
Main	IS	@
		

	[[INCLUDE ex7.mms]]

y	GREG	[[Y]]

	[[INCLUDE RegisterEqual.mms :x  y]]

	SET	$255,0
	TRAP	0,Halt,0
	
	[[INCLUDE print.mms]]

]]

[[SET a (1<<55)+(1<<24)+1 ]]

[[TEST 1]]
[[SET X	0]]
[[SET Y	[[a]]]]
[[Driver]]
[[END 1]]

[[TEST 2]]
[[SET X	1]]
[[SET Y	2]]
[[Driver]]
[[END 2]]

[[TEST 3]]
[[SET X	123]]
[[SET Y	246]]
[[Driver]]
[[END 3]]

[[TEST 4]]
[[SET X	(1<<63)]]
[[SET Y	0]]
[[Driver]]
[[END 4]]

[[TEST 5]]
[[SET X	(1<<63)+1]]
[[SET Y	2^[[a]]]]
[[Driver]]
[[END 5]]

[[TEST 6]]
[[SET X	(1<<63)+123]]
[[SET Y	246^[[a]]]]
[[Driver]]
[[END 6]]


	