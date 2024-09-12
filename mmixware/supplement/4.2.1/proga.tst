[[SET Driver
	   LOC	   Data_Segment
	   GREG	   @
U	   OCTA	   [[U]]
V	   OCTA	   [[V]]

	   LOC	   #100

[[INCLUDE print.mms]]

	   PREFIX  :
u	   GREG	   0
v	   GREG	   0

s	   IS	   $0
i	   IS	   $1
test	   IS	   $2
t	   IS	   $3
Main	   IS	   @
	   [[loop]]
	   [[setu]]
	   [[setv]]
	   SET	   t+1,u
	   SET	   t+2,v
	   PUSHJ   t,Fadd
	   FADD	   s,u,v
	   CMPU	   test,s,t
	   BNZ	   test,Error


	   SET	   t+1,u
	   SET	   t+2,v
	   PUSHJ   t,Fsub
	   FSUB	   s,u,v
	   CMPU	   test,s,t
	   BNZ	   test,Error
	   
	   [[repeat]]

	   SET	   $255,0
	   TRAP	   0,Halt,0

Error	   SET	   $255,u
	   [[printi u]]
	   [[printtab]]
	   [[printi v]]
	   [[printnl]]

	   SET	   $255,1
	   TRAP	   0,Halt,0

[[INCLUDE proga.mms ]]
[[INCLUDE normalize.mms]]

[[INCLUDE random.mms ]]

]]
[[SET U 0]]
[[SET V 0]]
[[SET loop %]]
[[SET repeat %]]

[[TEST 1 ]]
[[SET setu  FLOT u,1]]
[[SET setv  FLOT v,2]]

[[Driver]]
[[END 1]]


[[TEST 2 ]]
[[SET U 257251825094872011]]
[[SET V 257251825094872011]]
[[SET setu  LDOU u,U]]
[[SET setv  LDOU v,V]]

[[Driver]]
[[END 2]]



[[TEST 3 ]]

[[SET loop 
      SET  i,5000
Loop  IS   @
]]
[[SET repeat 
      SUB    i,i,1
      BP     i,Loop
]]
[[SET setu  

0H     	    PUSHJ	t,Random; SET u,t
	    PUSHJ	t,Random; SLU t,t,32; XOR	u,u,t
	    SET		t,u
	    ANDNH	t,#8000
      	    SRU		t,t,52
	    BZ		t,0B
	    NOR		t,u,0
	    ANDNH	t,#8000
      	    SRU		t,t,52
	    BZ		t,0B

]]
[[SET setv
  
0H     	    PUSHJ	t,Random; SET v,t
	    PUSHJ	t,Random; SLU t,t,32; XOR	v,v,t
	    SET		t,v
	    ANDNH	t,#8000
      	    SRU		t,t,52
	    BZ		t,0B
	    NOR		t,v,0
	    ANDNH	t,#8000
      	    SRU		t,t,52
	    BZ		t,0B
]]

[[Driver]]
[[END 3]]

[[ This next test case is a case where the TAOCP implementation is right
   but the MMIX implementation is wrong!
   Thanks go to Joe Zbiciak!
   After MMIX is updated, this test should be enabled.

[[TEST 4 ]]
[[SET U #C000000000000000]]
[[SET V #3CA8000000000000]]
[[SET setu  LDOU u,U]]
[[SET setv  LDOU v,V]]

[[Driver]]
[[END 4]]

]]

