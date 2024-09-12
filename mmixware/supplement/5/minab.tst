[[SET Driver

       LOC	#100
       GREG	@
A      OCTA	[[a]]
B      OCTA	[[b]]
Min    OCTA	[[min]]
Max    OCTA	[[max]]

a	IS	$0
b	IS	$1
min	IS	$2
max	IS	$3	
t	IS	$4	


Main	LDO	a,A
	LDO	b,B

[[INCLUDE minab.mms ]]
	 
	 LDO	t,Min
	 CMP	t,t,min
	 BNZ	t,Error

	 LDO	t,Max
	 CMP	t,t,max
	 BNZ	t,Error

	 SET	$255,0
	 TRAP	0,Halt,0

Error	 SET	$255,1
	 TRAP	0,Halt,0

]]


[[TEST 1 ]]
[[SET    a  5]]
[[SET    b  7]]
[[SET    min 5]]
[[SET    max 7]]
[[Driver]]
[[END 1]]


[[TEST 2 ]]
[[SET    a  7]]
[[SET    b  5]]
[[SET    min 5]]
[[SET    max 7]]
[[Driver]]	  
[[END 2]]


[[TEST 3 ]]
[[SET    a  5]]
[[SET    b  5]]
[[SET    min 5]]
[[SET    max 5]]
[[Driver]]	  
[[END 3]]


[[TEST 4 ]]
[[SET    a  0]]
[[SET    b  5]]
[[SET    min 0]]
[[SET    max 5]]
[[Driver]]	  
[[END 4]]

[[COMMENT the next two test work inspite of the sign, mixed signs do not work]]

[[TEST 7 ]]
[[SET    a  -7]]
[[SET    b  -5]]
[[SET    min -7]]
[[SET    max -5]]
[[Driver]]	  
[[END 7]]

[[TEST 8 ]]
[[SET    a  -1]]
[[SET    b  -2]]
[[SET    min -2]]
[[SET    max -1]]
[[Driver]]	  
[[END 8]]


