[[SET Driver

          LOC   Data_Segment
X         GREG  @
1H     	  TETRA  0
	  LOC	1B+#100000
Y	  GREG	@
1H	  TETRA	0
	  LOC	1B+#100000

          LOC   #100

[[INCLUDE print.mms]]

	  PREFIX	:
x	  IS	$0
y	  IS	$1
q	  IS	$2
p	  IS	$3
k	  IS	$4

t	  IS	$5	  	  

Main      SET	t+1,X
	  SET	t+2,Y
	  SET	t+3,[[N]]
	  PUSHJ	t,:Farey

	  
	  SET	  k,0
	  LDT	  x,X,k
	  LDT	  y,Y,k
	  BNZ	  x,Fail
	  CMP	  t,y,1
	  BNZ	  t,Fail
	  NEG	  q,1
	  FLOT	  q,q
Loop	  [[printi x]]
	  [[printc '/']]
	  [[printi y]]
	  [[printc ',']]
	  CMP	  t,x,y
	  BZ	  t,OK
	  FLOT	  x,x
	  FLOT	  y,y
	  FDIV	  p,x,y
	  FCMP	  t,q,p
	  BNN	  t,Fail
	  SET	  p,q
	  INCL	  k,4
	  LDT	  x,X,k
	  LDT	  y,Y,k	  
	  JMP	  Loop


Fail 	  [[printnl]]
	  SET	$255,1
          TRAP  0,Halt,0
          
OK	  [[printnl]]
    	  SET	$255,0
          TRAP  0,Halt,0


	  
[[INCLUDE ex21.mms]]



]]

[[TEST  1]]
[[SET N 1]]

[[Driver]]

[[END 1]]

[[TEST  2]]
[[SET N 2]]

[[Driver]]

[[END 2]]

[[TEST  3]]
[[SET N 3]]

[[Driver]]

[[END 3]]

[[TEST  7]]
[[SET N 7]]

[[Driver]]

[[END 7]]

[[TEST  8]]
[[SET N 13]]

[[Driver]]

[[END 8]]
