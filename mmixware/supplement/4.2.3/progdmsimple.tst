[[SET Driver

      LOC	Data_Segment
      GREG	@
Data  IS	@

[[INCLUDE progdm.dat]]

n     IS	(@-Data)/(3*16)		Number of tripples

      LOC	#100

[[INCLUDE print.mms]]

w0    IS	$0
w1    IS	$1
eu    IS	$2
ev    IS	$3
e     IS	$4	
d     IS	$5
p     IS	$6
i     IS	$7
t     IS	$8

Main  LDA	p,Data
      SET	i,n
Loop  LDOU	t+1,p,0
      LDOU	t+2,p,8
      LDOU	t+3,p,16
      LDOU	t+4,p,24
      PUSHJ	t,DFmul
      LDOU	w1,p,32
      LDOU	w0,p,40
      
      CMPU	d,t,w1
      BZ	d,1F
      ADDU	t,t,1
      CMPU	d,t,w1
      BNZ	d,Error
      
1H     SET	e,16		ignore 16 lowest bits
%      SUBU	d,t+1,w0
%      BZ	d,1F 
%      NEG	t,d
%      CSN	d,d,t		get absolute difference.
%      LDOU	eu,p,0
%      LDOU	ev,p,16
%      XOR	t,eu,ev
%      SET	e,1		same sign, rounding one bit
%      BZ	t,2F
%      ANDNH	ev,#8000
%      ANDNH	eu,#8000
%      SLU	ev,ev,48
%      SLU	eu,eu,48
%      SUB	eu,eu,ev
%      NEG	e,eu
%      CSN	e,e,eu		different signe
%      
2H    SRU	w0,w0,e
      SRU	t,t+1,e
      CMPU	d,t,w0
      BZ	d,1F
      INCML	t+1,1
      SRU	t,t+1,e
      CMPU	d,t,w0
      BNZ	d,Error
   
1H    ADD	p,p,3*16
      SUB	i,i,1
      BP	i,Loop


OK    SET	$255,0; TRAP	0,Halt,0

Error IS	@
      NEG	i,n,i
      [[printi :i]]
      [[printnl]]
      SET	$255,1; TRAP	0,Halt,0
        

[[INCLUDE progdmsimple.mms]]
[[INCLUDE dnormalize.mms]]

]]



[[TEST 1 addition]]
[[Driver]]
[[END 1]]

