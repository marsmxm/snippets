[[SET Driver
	LOC	Data_Segment
	GREG	@
X	OCTA	[[x]]
	LOC	#100
Main	IS	@

a0	GREG	0	%%tex	$\alpha_0$
a1	GREG	0	%%tex	$\alpha_1$
a2	GREG	0	%%tex	$\alpha_2$
a3	GREG	0	%%tex	$\alpha_3$
a4	GREG	0	%%tex	$\alpha_4$
a5	GREG	0	%%tex	$\alpha_5$

x	IS	$0	%%tex	$x$
y	IS	$1	%%tex	$y$
u	IS	$2	%%tex	$u$
s	IS	$3
t	IS	$4	%%tex	$t$

	LDO	x,X
	FLOT	x,x

	FLOT	a0,0
	NEG	a1,10; FLOT a1,a1
	FLOT	a2,13
	FLOT	a3,5
	NEG	a4,5; FLOT  a4,a4
	FLOT	a5,1

[[INCLUDE fifth.mms ]]

	FLOT	t,5
	FADD	s,x,t	x+5
	FMUL	s,s,x	(x+5)x
	NEG	t,10; FLOT t,t
	FADD	s,s,t   (x+5)x-10
	FMUL	s,s,x	((x+5)-10)*x
	NEG	t,50; FLOT t,t
	FADD	s,s,t   ((x+5)x-10)*x-50
	FMUL	s,s,x	(((x+5)-10)*x-50)x
	FLOT 	t,13
	FADD	s,s,t   (((x+5)x-10)*x-50)x+13
	FMUL	s,s,x	((((x+5)x-10)*x-50)x+13)x
	FLOT 	t,60
	FADD	s,s,t   ((((x+5)x-10)*x-50)x+13)x+60

	CMPU	t,s,u
	
	BNZ	t,Error

OK	SET	    $255,0
	TRAP	    0,Halt,0

Error	SET	    $255,1
	TRAP	    0,Halt,0
]]

[[TEST 1 ]]
[[SET x  0]]

[[Driver]]
[[END 1]]

[[TEST 2 ]]
[[SET x  1]]
[[Driver]]
[[END 2]]


[[TEST 3 ]]
[[SET x  17]]
[[Driver]]
[[END 3]]


[[TEST 4 ]]
[[SET x  -3]]
[[Driver]]
[[END 4]]

[[TEST 5 ]]
[[SET x  -13]]
[[Driver]]
[[END 5]]


