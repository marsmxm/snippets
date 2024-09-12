[[TEST 1 ]]
       LOC	Data_Segment
In       GREG	@
[[INCLUDE	ex15.in.octa]]

       GREG	@
Out    IS	@
[[INCLUDE	ex15.out.octa]]

       GREG	@
Result OCTA	0
       LOC	Result+#1000


	GREG	@
BASECOL	OCTA	0	LEFT
	OCTA	0	UP	here we start UP(BASECOL).
	LOC	BASECOL+#1000
	GREG	@
BASEROW	OCTA	0
	LOC	BASEROW+#1000
	GREG	@
PTR	OCTA	0
	LOC	PTR+#1000


       LOC	#100

[[COMMENT Allocate and Free from exercises 2.5-27 and 2.5-28 
m	 IS 	   10
[[INCLUDE ../2.5/ex27.mms]]
[[INCLUDE ../2.5/ex28.mms]]
[[INCLUDE ../2.5/findtag.mms]]
]]
	PREFIX	:Allocate:
Base	GREG	:Pool_Segment
Limit	GREG	0
Free	GREG	0

:Allocate BZ	Free,1F
	  SET	$0,Free
	  LDOU	Free,$0,0
	  POP	1,0
1H	  ADDU	$0,Base,Limit
	  ADD	Limit,Limit,32	four octabyte
	  POP	1,0

:Free	  STOU	Free,$0,0
	  SET	Free,$0
	  POP	0,0

[[INCLUDE empty.mms]]
[[INCLUDE flaten.mms]]
[[INCLUDE insert.mms]]

[[INCLUDE ex15.mms ]]


       PREFIX   :Main:

n	IS	4
m	IS	4

i	IS	$0
j	IS	$1
P	IS	$2
t      IS	$3
:Main  SET	t,10000		   set rE to 1/10000
       FLOT	t,t
       FLOT	t+1,1
       FDIV	t,t+1,t
       PUT	:rE,t

[[       PUSHJ	t,:Init	Initialize memory allocation ]]

     
       LDA	t+1,:BASEROW
       LDA	t+2,:BASECOL
       SET	t+3,n
       SET	t+4,m
       PUSHJ	t,:Empty

       SET	t,n*m
       8ADDU	P,t,:In
       SET	i,n
1H     SUB	i,i,1
       SET	j,m
2H     SUB	j,j,1
       SUBU	P,P,8
       
       LDA	t+1,:BASEROW
       LDA	t+2,:BASECOL
       SET	t+3,i
       SET	t+4,j
       LDOU	t+5,P,0 
       PUSHJ	t,:Insert
       BP	j,2B
       BP	i,1B     


       LDA	t+2,:BASEROW
       LDA	t+3,:BASECOL
       SET	t+4,2-1
       SET	t+5,1-1
       PUSHJ	t+1,:GetSparse
       BZ	t+1,Fail

       LDA	t+2,:BASEROW
       LDA	t+3,:BASECOL
       LDA	t+4,:PTR
       PUSHJ	t,:PStep

       LDA	t+1,:BASEROW
       LDA	t+2,:BASECOL
       SET	t+3,n
       SET	t+4,m
       LDA	t+5,:Result
       PUSHJ	t,:Flatten
 
[[INCLUDE OctaEqual.mms :Out :Result n*m ]]


OK     SET	$255,0
       TRAP	0,:Halt,0
Fail   SET	$255,1
       TRAP	0,:Halt,0


 



[[END 1]]

