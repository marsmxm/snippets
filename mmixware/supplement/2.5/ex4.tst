[[SET Driver

       LOC	Data_Segment
BASE   IS	@
base   GREG	BASE

[[AVAIL]]	

AVAIL  TETRA	1B-BASE



       LOC	#100
Main   SET	$1,[[N]]
       PUSHJ	$0,:Allocate

[[Test]]

OK       SET	$255,0
       TRAP	0,Halt,0


Fail   SET	$255,1
       TRAP	0,Halt,0

[[INCLUDE ex4.mms ]]

]]

[[TEST 1 ]]
[[SET AVAIL 
1H      TETRA	100,#FFFFFFFF
	LOC	1B+99
]]
[[SET N 15]]
[[SET Test
      BZ	$0,Fail
]]
[[Driver]]
[[END 1]]

[[TEST 2 ]]
[[SET AVAIL 
1H      TETRA	100,#FFFFFFFF
	LOC	1B+99
]]
[[SET N 150]]
[[SET Test
      BNZ	$0,Fail
]]
[[Driver]]
[[END 2]]

[[TEST 3 ]]
[[SET AVAIL 
1H      TETRA	100,#FFFFFFFF
	LOC	1B+99
]]
[[SET N 100]]
[[SET Test
      BZ	$0,Fail
]]
[[Driver]]
[[END 3]]

[[TEST 4 ]]
[[SET AVAIL 
1H      TETRA	10,#FFFFFFFF
	LOC	1B+9
1H      TETRA	100,1B-BASE
	LOC	1B+99
1H      TETRA	10,1B-BASE
	LOC	1B+9
]]
[[SET N 100]]
[[SET Test
      BZ	$0,Fail
]]
[[Driver]]
[[END 4]]

[[TEST 5 ]]
[[SET AVAIL 
1H      TETRA	10,#FFFFFFFF
1H      TETRA	150,1B-BASE
1H      TETRA	10,1B-BASE
]]
[[SET N 100]]
[[SET Test
      BZ	$0,Fail
]]
[[Driver]]
[[END 5]]

[[TEST 6 ]]
[[SET AVAIL 
1H      TETRA	10,#FFFFFFFF
1H      TETRA	15,1B-BASE
1H      TETRA	10,1B-BASE
]]
[[SET N 100]]
[[SET Test
      BNZ	$0,Fail
]]
[[Driver]]
[[END 6]]

