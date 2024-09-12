[[SET Driver

		LOC	:Data_Segment
		GREG	@
rover		GREG	0		
		TETRA	0			Align AVAIL

AVAIL		TETRA	0			SIZE=0
		TETRA	6*4			RLINK=1F-AVAIL
		TETRA	6*4			LLINK=1F-AVAIL
		TETRA	0			SIZE=0

		TETRA	1,1			Mark as used (see Algorithm C).

1H		TETRA	[[Total]]-16		SIZE
		TETRA	0,0			RLINK=LLINK=AVAIL
		LOC	1B+[[Total]]-4
		TETRA	[[Total]]-16
		TETRA	1			Mark as used (see Algorithm C).
				
%

	LOC	#100
i	  IS	$0
n	  IS	$1
befor	  IS	$2
p	  IS	$3
t	  IS	$4

Main	  SET	rover,0
	  SET	i,[[n]]
1H	  SUB	i,i,1
	  BNP	i,9F
	  PUSHJ	t,:Random
	  DIV	t,t,[[r]]
	  GET	n,rR
	  ADD	n,n,1	
	  SET	p+1,n
	  PUSHJ	p,Allocate
	  BZ	p,Fail
3H	  BNP	n,2F
	  STBU	n,p,0
	  SUB	n,n,1
	  ADD	p,p,1
	  JMP	3B	  
2H	  JMP	1B

9H	  SET	$255,0
	  TRAP	0,Halt,0

Fail	  SET	$255,1
	  TRAP	0,Halt,0


[[INCLUDE ex13.mms]]

[[INCLUDE random.mms]]

]]


[[TEST 1]]
[[SET Total 500]]
[[SET n 10]]
[[SET r 30]]

       [[Driver]]


[[END 1]]