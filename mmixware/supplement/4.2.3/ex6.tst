[[SET Driver
		LOC	#100
Data		GREG	@
		[[Data]]
		
x		IS	$0
xm		IS	$1
xl		IS	$2
test		IS	$3
t		IS	$4

Main		LDOU	x,Data,0
		LDOU	xm,Data,8
		LDO	xl,Data,16
		SET	t+2,x
		PUSHJ	t+1,ToDouble
		
		CMPU	test,xm,t+1
		BNZ	test,Error		
		CMPU	test,xl,t+2
		BNZ	test,Error		

		PUSHJ	t,ToSingle
		
		CMPU	test,t,x
		BNZ	test,Error

		SET	$255,0
		TRAP	0,Halt,0

Error		SET	$255,1
		TRAP	0,:Halt,0


[[INCLUDE ex6.mms]]
[[INCLUDE ex6b.mms]]
[[INCLUDE ../4.2.1/normalize.mms]]

]]

[[TEST 1]]
[[SET  Data
       OCTA	#3FF0000000000000
       OCTA	#3FFF000000000000,#0000000000000000	1.000000
]]
[[Driver]]
[[END 1]]

[[TEST 2]]
[[SET  Data
       OCTA	#3FF5555555555555
       OCTA	#3FFF555555555555,#5000000000000000	1.333333
]]
[[Driver]]
[[END 2]]

[[TEST 3]]
[[SET  Data
       OCTA	#BFF5555555555555
       OCTA	#BFFF555555555555,#5000000000000000	1.333333
]]
[[Driver]]
[[END 3]]

[[TEST 4]]
[[SET  Data
       OCTA	#CFF5555555555555
       OCTA	#C0FF555555555555,#5000000000000000	1.333333
]]
[[Driver]]
[[END 4]]