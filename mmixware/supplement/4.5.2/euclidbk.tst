[[SET Driver
	LOC	#100
	GREG	@
U	OCTA	[[u]]
V	OCTA	[[v]]
GCD	OCTA	[[gcd]]

Main	LDO	$1,U
	LDO	$2,V
	PUSHJ	$0,Gcd
	LDO	$1,GCD
	CMP	$255,$1,$0
	TRAP	0,Halt,0

[[INCLUDE euclidbk.mms]]

]]

[[TEST 1]]
[[SET u 6]]
[[SET v 3]]
[[SET gcd 3]]
[[Driver]]
[[END 1]]
	
[[TEST 4]]
[[SET u 1]]
[[SET v 6]]
[[SET gcd 1]]
[[Driver]]
[[END 4]]


[[TEST 5]]
[[SET u 6]]
[[SET v 1]]
[[SET gcd 1]]
[[Driver]]
[[END 5]]


[[TEST 6]]
[[SET u 12]]
[[SET v 18]]
[[SET gcd 6]]
[[Driver]]
[[END 6]]
	
[[TEST 7]]
[[SET u 2*2*17*19*19*1001*5*7]]
[[SET v 2*17*19*1001*7*7*7*1001*13*23]]
[[SET gcd 2*17*19*1001*7]]
[[Driver]]
[[END 7]]
