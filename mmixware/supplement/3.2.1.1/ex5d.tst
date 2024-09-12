[[SET Driver

	LOC	Data_Segment
	GREG	@

xx	OCTA	[[x]]
yy	OCTA	[[y]]
mm	OCTA	[[m]]

	LOC	#100
x	IS	$0
y	IS	$1
m	IS	$2
s	IS	$3
t	IS	$5

Main	LDOU	x,xx
	LDOU	y,yy
	LDOU	m,mm

[[INCLUDE ex5d.mms]]


[[INCLUDE expect.mms "s" :s [[result]]]]

	SET	$255,0
	TRAP	0,Halt,0


[[INCLUDE print.mms]]


]]


[[TEST 1]]
[[SET x 5]]
[[SET y 1]]
[[SET m 7]]
[[SET result ([[x]]+[[y]])]]


[[Driver]]

[[END 1]]

[[TEST 2]]
[[SET x 6]]
[[SET y 5]]
[[SET m 7]]
[[SET result ([[x]]+[[y]])-[[m]]]]

[[Driver]]

[[END 2]]

[[TEST 3]]
[[SET x ([[m]]-1)]]
[[SET y ([[m]]-1)]]
[[SET m #7000000000000000]]
[[SET result ([[x]]+[[y]]-[[m]])]]

[[Driver]]

[[END 3]]