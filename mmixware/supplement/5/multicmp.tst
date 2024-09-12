[[SET Driver 
      	 LOC	#100
	 GREG	@

A	 BYTE	[[a]]
B	 BYTE	[[b]]
N	 OCTA	[[n]]
X	 OCTA	[[cmp]]

Main	 LDO	$1,N
	 LDA	$2,A
	 LDA	$3,B
	 PUSHJ	$0,MCmp
	 
	 LDO	$1,X
	 CMP	$2,$0,$1
	 BNZ	$2,Error

	 SET	$255,0
	 TRAP	0,Halt,0

Error	 SET	$255,1
	 TRAP	0,Halt,0
	
[[INCLUDE multicmp.mms ]]

 
]]

[[TEST 1 ]]
[[SET n   5]]
[[SET a   1,2,3,4,5]]
[[SET b   1,2,4,4,5]]
[[SET cmp -1]]
[[Driver]]
[[END 1]]


[[TEST 2 ]]
[[SET n   5]]
[[SET a   1,2,3,4,5]]
[[SET b   1,2,3,4,5]]
[[SET cmp 0]]
[[Driver]]
[[END 2]]


[[TEST 3 ]]
[[SET n   5]]
[[SET a   1,2,3,4,5]]
[[SET b   7,6,2,4,5]]
[[SET cmp 1]]
[[Driver]]
[[END 3]]

