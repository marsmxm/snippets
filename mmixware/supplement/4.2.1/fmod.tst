[[SET Driver

      LOC	Data_Segment
      
      LOC	#100
       
[[INCLUDE fmod.mms]]
[[INCLUDE normalize.mms]]

      PREFIX	:
u     GREG	0

v     IS	$0
w     IS	$1
t     IS	$2

Main  IS	@

      [[setu]]

      SET	t+1,u
    
      PUSHJ	t,Fmod

      BN	t,Error

      FSUB	v,u,t
      FINT	w,ROUND_DOWN,u
      CMPU	t,v,w
      BNZ	t,Error
            		
      SET	t,0
      FSUB	u,t,u	test also -u
      SET	t+1,u
      PUSHJ	t,Fmod

      BN	t,Error

      FSUB	v,u,t
      FINT	w,ROUND_DOWN,u
      CMPU	t,v,w
      BNZ	t,Error
 

      SET	$255,0
      TRAP	0,Halt,0

Error SET	$255,1
      TRAP	0,Halt,0
            		
]]




[[TEST 1]]
[[SET setu  FLOT u,1; FLOT t,3; FDIV u,u,t ]] 
[[Driver]]
[[END 1]]


[[TEST 2]]
[[SET setu  FLOT u,2; FLOT t,3; FDIV u,u,t ]] 
[[Driver]]
[[END 2]]


[[TEST 3]]
[[SET setu  FLOT u,3; FLOT t,3; FDIV u,u,t ]] 
[[Driver]]
[[END 3]]

[[TEST 4]]
[[SET setu  FLOT u,4; FLOT t,3; FDIV u,u,t ]] 
[[Driver]]
[[END 4]]


[[TEST 5]]
[[SET setu  FLOT u,251; FLOT t,3; FDIV u,u,t ]] 
[[Driver]]
[[END 5]]


[[TEST 6]]
[[SET setu  FLOT u,252; FLOT t,3; FDIV u,u,t ]] 
[[Driver]]
[[END 6]]


[[TEST 7]]
[[SET setu  FLOT u,253; FLOT t,3; FDIV u,u,t ]] 
[[Driver]]
[[END 7]]


[[TEST 8]]
[[SET setu  SETH u,#0010 ]] 
[[Driver]]
[[END 8]]


[[TEST 9]]
[[SET setu  SETH u,#7fe0 ]] 
[[Driver]]
[[END 9]]

[[TEST 10]]
[[SET setu  SETH u,#5000 ]] 
[[Driver]]
[[END 10]]