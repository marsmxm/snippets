
[[COMMENT
	%% this variation of exercise 27 uses a directory entry 
        %% with SIZE=0 to mark the end of the list.
        %% the code in phase 2 is nicer then!
]]

[[SET Driver

	LOC	Data_Segment
	GREG	@
Dir	TETRA	20,#24,#0c|1			#00
	TETRA	30,#48|1			#0c
	TETRA	200,#34,#00,#2C|1		#14
	TETRA	100,#14|1			#24
	TETRA	60,#00|1			#2C
	TETRA	200,#50,#24,#0C,#2C|1		#34
	TETRA	20,#2C|1			#48
	TETRA	0,0				#50 Termination

Start	TETRA	#0c

Solution TETRA	2400,#0C
	TETRA	2430,#48
	TETRA	2450,#2C
	TETRA	2510,#00
	TETRA	2530,#14
	TETRA	2730,#00

Stack	OCTA	#14
	OCTA	#48



	LOC	#100

Main	LDA	$1,Dir
	LDA	$2,Stack
	SET	$3,[[n]]
	SET	$4,[[mloc]]
	LDTU	$5,Start

	PUSHJ	$0,Ex27

	[[INCLUDE TetraEqual.mms :Stack :Solution 12]]]

	SET	$255,0; TRAP 0,Halt,0

[[INCLUDE ex27space.mms]]

]]

[[SET n 2]]
[[SET mloc 2400]]

[[TEST 1]]
[[Driver]]
[[END 1]]
	