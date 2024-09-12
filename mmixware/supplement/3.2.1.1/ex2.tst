[[SET Driver

a	GREG  [[a]]
x	GREG  [[X]]
c	GREG  [[c]]


	LOC	#100
Main	IS	@

	PUSHJ	$0,:Random

[[INCLUDE expect.mms "X" $0 [[result]]]]

	SET	$255,0
	TRAP	0,Halt,0


[[INCLUDE ex2.mms]]


[[INCLUDE print.mms]]


]]


[[TEST 1]]
[[SET a 5]]
[[SET X 2]]
[[SET c 7]]
[[SET result 17]]


[[Driver]]

[[END 1]]


[[TEST 2]]
[[SET a 2]]
[[SET X #8000000000000001]]
[[SET c 7]]
[[SET result 9]]


[[Driver]]

[[END 2]]


[[TEST 3]]
[[SET a 2]]
[[SET X #FFFFFFFFFFFFFFFF]]
[[SET c 7]]
[[SET result 5]]


[[Driver]]

[[END 3]]


[[TEST 4]]
[[SET a 2]]
[[SET X #7FFFFFFFFFFFFFFF]]
[[SET c 7]]
[[SET result 5]]


[[Driver]]

[[END 4]]

[[TEST 5]]
[[SET a 2]]
[[SET X #3FFFFFFFFFFFFFFF]]
[[SET c 7]]
[[SET result [[X]]*[[a]]+[[c]] ]]


[[Driver]]

[[END 5]]

	