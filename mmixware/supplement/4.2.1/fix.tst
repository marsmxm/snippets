[[SET Driver

	LOC	#100

[[INCLUDE fix.mms]]

	   PREFIX :
i	   IS	  $0
test	   IS	  $1
t	   IS	  $2
u	   GREG	  0
Main	   IS	  @
	   [[setu]]
	   SET	   t+1,u
           PUSHJ   t,Fix
	   FIX	   i,u
	   CMP	   test,t,i
	   BNZ	   test,Error

	   SET	   $255,0
	   TRAP	   0,Halt,0

Error	   SET	   $255,1
	   TRAP	   0,Halt,0

]]

[[TEST 1]]
[[SET setu  FLOT u,77]]
[[Driver]]
[[END 1]]

[[TEST 2]]
[[SET setu NEG	   u,33;  FLOT	u,u]]
[[Driver]]
[[END 2]]

[[TEST 3]]
[[SET setu  FLOT u,1; FLOT t,2; FDIV u,u,t ]]
[[Driver]]
[[END 3]]

[[TEST 4]]
[[SET setu  FLOT u,2; FLOT t,3; FDIV u,u,t ]]
[[Driver]]
[[END 4]]

[[TEST 5]]
[[SET setu  FLOT u,1; FLOT t,3; FDIV u,u,t ]]
[[Driver]]
[[END 5]]

[[TEST 6]]
[[SET setu  FLOT u,0]]
[[Driver]]
[[END 6]]

[[TEST 7]]
[[SET setu  SET u,0]]
[[Driver]]
[[END 7]]

[[TEST 8]]
[[SET setu  SETH u,#8000; SUBU	u,u,1; ANDNL u,#200; FLOT u,u]]
[[Driver]]
[[END 8]]

[[TEST 9]]
[[SET setu  SETH u,#8000; FLOT u,u]]
[[Driver]]
[[END 9]]

