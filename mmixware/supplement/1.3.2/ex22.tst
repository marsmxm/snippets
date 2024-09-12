[[SET Driver
	  LOC		Data_Segment
X	  GREG		@
A	  BYTE 		0
	  LOC		A+[[n]]
Result	  BYTE		[[Result]]


       LOC	#100
[[INCLUDE print.mms]]
[[INCLUDE ex22.mms]]

	  PREFIX	:
	  

before	  GREG
after	  GREG
x	  IS		$2
i	  IS		$3
t	  IS		$4

Main 	  SET		t+1,[[n]]
	  SET		t+2,[[m]]
	  SET		t+3,X
	  GET		before,rI
	  PUSHJ		t,:Josephus
	  GET		after,rI

	  [[Print]]


	  [[Verify]]	  

	  [[Runtime]]


OK	  SET		$255,0
	  TRAP		0,Halt,0
]]

[[SET Runtime
          [[INCLUDE runtime.mms :before :after [[time]] 5]]
]]

[[SET Print
	  SET i,0
0H	  LDBU	x,X,i
	  [[printi	:x]]
	  [[printc	',']]
	  ADD	i,i,1
	  CMP	t,i,[[n]]
          PBN	t,0B
	  [[printnl]]
]]


[[SET Verify 
      [[INCLUDE ByteEqual.mms :A :Result [[n]]]]
]]

[[TEST 1]]
[[SET n 8]]
[[SET m  4]]
[[SET Result 5,4,6,1,3,8,7,2]]
[[SET time 142]]
[[Driver]]

[[END 1]]

[[TEST 2]]
[[SET n 24]]
[[SET m  11]]
[[SET Result 15,12,22,8,16,11,23,21,3,5,1,17,10,7,24,19,20,18,9,14,4,2,13,6]]
[[SET time 913]]


[[Driver]]

[[END 2]]

