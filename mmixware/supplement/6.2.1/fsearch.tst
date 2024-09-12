
[[SET Driver

		LOC	Data_Segment
		GREG	@
MINOCTA	IS	#8000000000000000
Fib		OCTA	1,1,2,3,5,8,13,21,34
		OCTA	MINOCTA
Data		[[In]]
		GREG	@
i		OCTA	[[i]]
p		OCTA	[[p]]
q		OCTA	[[q]]
Key		OCTA	[[Key]]

		LOC	#100
Main		LDA	$1,Data
		LDO	$2,Key
		LDO	$3,i
		LDO	$4,p
		LDO	$5,q
		PUSHJ	$0,Search

		[[Test]]

OK		SET	$255,0 
		TRAP 0,Halt,0

Error		SET	$255,1 
		TRAP 0,Halt,0



[[INCLUDE fsearch.mms]]

]]

[[SET IsNull  BNZ	$0,Error]]
[[SET IsValue 
	LDO 	$1,$0,0
	LDO	$2,Key
	CMP	$3,$1,$2
	BNZ	$3,Error]]
	

[[TEST 1]]
	[[COMMENT N=1, N+1=2=F3 i = F2]]
	[[SET i     1*8-8]]
	[[SET p     1*8]]
	[[SET q     0*8]]
	[[SET In  OCTA 5]]
	[[SET Key   MINOCTA]]
	[[SET Test [[IsNull]]]]	
	[[Driver]]
[[END 1]]

[[TEST 2]]
	[[COMMENT N=1, N+1=2=F3 i = F2]]
	[[SET i     1*8-8]]
	[[SET p     1*8]]
	[[SET q     0*8]]
	[[SET In  OCTA 5]]
	[[SET Key   5]]
	[[SET Test [[IsValue]]]]	
	[[Driver]]
[[END 2]]

[[TEST 3]]
	[[COMMENT N=1, N+1=2=F3 i = F2]]
	[[SET i     1*8-8]]
	[[SET p     1*8]]
	[[SET q     0*8]]
	[[SET In  OCTA 5]]
	[[SET Key   10]]
	[[SET Test [[IsNull]]]]	
	[[Driver]]
[[END 3]]

[[TEST 4]]
	[[COMMENT N=2, N+1=3=F4 i = F3]]
	[[SET i     2*8-8]]
	[[SET p     1*8]]
	[[SET q     1*8]]
	[[SET In  OCTA 5,7]]
	[[SET Key   10]]
	[[SET Test [[IsNull]]]]	
	[[Driver]]
[[END 4]]

[[TEST 5]]
	[[COMMENT N=2, N+1=3=F4 i = F3]]
	[[SET i     2*8-8]]
	[[SET p     1*8]]
	[[SET q     1*8]]
	[[SET In  OCTA 5,7]]
	[[SET Key   7]]
	[[SET Test [[IsValue]]]]	
	[[Driver]]
[[END 5]]

[[TEST 6]]
	[[COMMENT N=2, N+1=3=F4 i = F3]]
	[[SET i     2*8-8]]
	[[SET p     1*8]]
	[[SET q     1*8]]
	[[SET In  OCTA 5,7]]
	[[SET Key   6]]
	[[SET Test [[IsNull]]]]	
	[[Driver]]
[[END 6]]

[[TEST 7]]
	[[COMMENT N=2, N+1=3=F4 i = F3]]
	[[SET i     2*8-8]]
	[[SET p     1*8]]
	[[SET q     1*8]]
	[[SET In  OCTA 5,7]]
	[[SET Key   5]]
	[[SET Test [[IsValue]]]]	
	[[Driver]]
[[END 7]]

[[TEST 8]]
	[[COMMENT N=2, N+1=3=F4 i = F3]]
	[[SET i     2*8-8]]
	[[SET p     1*8]]
	[[SET q     1*8]]
	[[SET In  OCTA 5,7]]
	[[SET Key   MINOCTA]]
	[[SET Test [[IsNull]]]]	
	[[Driver]]
[[END 8]]

[[TEST 9]]
	[[COMMENT N=4, N+1=5=F5 i = F4]]
	[[SET i     3*8-8]]
	[[SET p     2*8]]
	[[SET q     1*8]]
	[[SET In  OCTA 5,7,9,11]]
	[[SET Key   MINOCTA]]
	[[SET Test [[IsNull]]]]	
	[[Driver]]
[[END 9]]

[[TEST 10]]
	[[COMMENT N=4, N+1=5=F5 i = F4]]
	[[SET i     3*8-8]]
	[[SET p     2*8]]
	[[SET q     1*8]]
	[[SET In  OCTA 5,7,9,11,12]]
	[[SET Key   12]]
	[[SET Test [[IsNull]]]]	
	[[Driver]]
[[END 10]]

[[TEST 11]]
	[[COMMENT N=4, N+1=5=F5 i = F4]]
	[[SET i     3*8-8]]
	[[SET p     2*8]]
	[[SET q     1*8]]
	[[SET In  OCTA 5,7,9,11,12]]
	[[SET Key   10]]
	[[SET Test [[IsNull]]]]	
	[[Driver]]
[[END 11]]

[[TEST 12]]
	[[COMMENT N=4, N+1=5=F5 i = F4]]
	[[SET i     3*8-8]]
	[[SET p     2*8]]
	[[SET q     1*8]]
	[[SET In  OCTA 5,7,9,11,12]]
	[[SET Key   5]]
	[[SET Test [[IsValue]]]]	
	[[Driver]]
[[END 12]]

[[TEST 13]]
	[[COMMENT N=4, N+1=5=F5 i = F4]]
	[[SET i     3*8-8]]
	[[SET p     2*8]]
	[[SET q     1*8]]
	[[SET In  OCTA 5,7,9,11,12]]
	[[SET Key   7]]
	[[SET Test [[IsValue]]]]	
	[[Driver]]
[[END 13]]

[[TEST 14]]
	[[COMMENT N=4, N+1=5=F5 i = F4]]
	[[SET i     3*8-8]]
	[[SET p     2*8]]
	[[SET q     1*8]]
	[[SET In  OCTA 5,7,9,11,12]]
	[[SET Key   9 ]]
	[[SET Test [[IsValue]]]]	
	[[Driver]]
[[END 14]]

[[TEST 15]]
	[[COMMENT N=4, N+1=5=F5 i = F4]]
	[[SET i     3*8-8]]
	[[SET p     2*8]]
	[[SET q     1*8]]
	[[SET In  OCTA 5,7,9,11,12]]
	[[SET Key   11]]
	[[SET Test [[IsValue]]]]	
	[[Driver]]
[[END 15]]


[[COMMENT Example 5.2.1 page 411]]
[[TEST 16]]
	[[COMMENT N=12, N+1=13=F7 i = F6]]
	[[SET i     8*8-8]]
	[[SET p     5*8]]
	[[SET q     3*8]]
	[[SET In  OCTA 061,087,154,170,275,462,505,509,512,612,653,677,703,765,897,908]]
	[[SET Key   653]]
	[[SET Test [[IsValue]]]]
	
	[[Driver]]
[[END 16]]
[[TEST 17]]
	[[SET i     8*8-8]]
	[[SET p     5*8]]
	[[SET q     3*8]]
	[[SET In  OCTA 061,087,154,170,275,462,505,509,512,612,653,677,703,765,897,908]]
	[[SET Key   703]]
	[[SET Test [[IsNull]]]]
	
	[[Driver]]
[[END 17]]
[[TEST 18]]
	[[SET i     8*8-8]]
	[[SET p     5*8]]
	[[SET q     3*8]]
	[[SET In  OCTA 061,087,154,170,275,462,505,509,512,612,653,677,703,765,897,908]]
	[[SET Key   MINOCTA]]
	[[SET Test [[IsNull]]]]
	
	[[Driver]]
[[END 18]]
[[TEST 19]]
	[[SET i     8*8-8]]
	[[SET p     5*8]]
	[[SET q     3*8]]
	[[SET In  OCTA 061,087,154,170,275,462,505,509,512,612,653,677,703,765,897,908]]
	[[SET Key   171]]
	[[SET Test [[IsNull]]]]
	
	[[Driver]]
[[END 19]]
[[TEST 20]]
	[[SET i     8*8-8]]
	[[SET p     5*8]]
	[[SET q     3*8]]
	[[SET In  OCTA 061,087,154,170,275,462,505,509,512,612,653,677,703,765,897,908]]
	[[SET Key   61 ]]
	[[SET Test [[IsValue]]]]
	
	[[Driver]]
[[END 20]]

