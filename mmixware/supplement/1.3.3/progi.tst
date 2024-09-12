[[SET Driver
      LOC	Data_Segment
      GREG	@
In    BYTE	[[in]]
Out   BYTE	[[out]]
      LOC	#100

[[INCLUDE progi.mms]]
[[INCLUDE print.mms]]

t	  IS	$0
Main  	  LDA	t+1,In
	  SET	t+2,[[n]]
	  PUSHJ	t,:Invert

	  [[INCLUDE ByteEqual.mms :In :Out [[n]]]]

	  SET	    $255,0
	  TRAP	    0,Halt,0
]]

[[TEST 1]]
[[SET in  6,2,1,5,4,3]]
[[SET out 3,2,6,5,4,1]]
[[SET n 6]]
[[Driver]]
[[END 1]]

[[TEST 2]]
[[SET in  1]]
[[SET out 1]]
[[SET n 1]]
[[Driver]]
[[END 2]]

[[TEST 3]]
[[SET in  1,2]]
[[SET out 1,2]]
[[SET n 2]]
[[Driver]]
[[END 3]]

[[TEST 4]]
[[SET in  2,1]]
[[SET out 2,1]]
[[SET n 2]]
[[Driver]]
[[END 4]]

[[TEST 5]]
[[SET in  2,1,3]]
[[SET out 2,1,3]]
[[SET n 3]]
[[Driver]]
[[END 5]]