[[SET Driver


	LOC	#100

[[INCLUDE flot.mms]]
[[INCLUDE normalize.mms]]

	   PREFIX  :

n	   GREG		[[n]]

Main	   SET	   $1,n
           PUSHJ   $0,Flot
	   SET	   $1,n
	   FLOT	   $2,$1
	   FEQL	   $3,$2,$1
	   BNZ	   $3,Error	

OK	   SET	   $255,0
	   TRAP	   0,Halt,0

Error	   SET	   $255,1
	   TRAP	   0,Halt,0
]]


[[TEST 1]]
[[SET n 1]]
[[Driver]]
[[END 1]]

[[TEST 2]]
[[SET n -1]]
[[Driver]]
[[END 2]]

[[TEST 3]]
[[SET n 1<<52]]
[[Driver]]
[[END 3]]

[[TEST 4]]
[[SET n 1<<53]]
[[Driver]]
[[END 4]]

[[TEST 5]]
[[SET n 1<<63]]
[[Driver]]
[[END 5]]