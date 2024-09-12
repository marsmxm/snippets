[[SET Driver

a	GREG  [[a]]
x	GREG  [[X]]
c	GREG  [[c]]


	LOC	#100
Main	IS	@

	[[INCLUDE ex8.mms]]


[[INCLUDE expect.mms "X" :x [[result]]]]

	SET	$255,0
	TRAP	0,Halt,0

[[INCLUDE print.mms]]


]]

[[SET c 0]]

[[TEST 1]]
[[SET a 5]]
[[SET X 2]]

[[SET result 10]]


[[Driver]]

[[END 1]]


[[TEST 2]]
[[SET a 2]]
[[SET X #8000000000000001]]
[[SET result 3]]


[[Driver]]

[[END 2]]


[[TEST 3]]
[[SET a 2]]
[[SET X #FFFFFFFFFFFFFFFF]]
[[SET result -1]]


[[Driver]]

[[END 3]]


[[TEST 4]]
[[SET a 2]]
[[SET X #7FFFFFFFFFFFFFFF]]
[[SET result -2]]


[[Driver]]

[[END 4]]

[[TEST 5]]
[[SET a 2]]
[[SET X #3FFFFFFFFFFFFFFF]]
[[SET c 7]]
[[SET result [[X]]*[[a]] ]]


[[Driver]]

[[END 5]]

	