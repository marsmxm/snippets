% Example program ... Table of primes (floating point with sharper bound)
L      IS   500          The number of primes to find
t      IS   $255         Temporary storage
n      GREG
q      GREG
r      GREG
jj     GREG
kk     GREG
pk     GREG
mm     IS   kk

       LOC  Data_Segment
PRIME1 WYDE 2
       LOC  PRIME1+2*L
ptop   GREG @
j0     GREG PRIME1+2-@
BUF    OCTA

       LOC  #100
Main   SET  n,3
       SET  jj,j0
2H     STWU n,ptop,jj
       INCL jj,2
3H     BZ   jj,2F
4H     INCL n,2
5H     SET  kk,j0
fn    GREG 0
sqrtn GREG 0
      FLOT fn,n
      FSQRT sqrtn,fn
0H    GREG #3fffff0000000000
      FSUB  sqrtn,sqrtn,0B
6H     LDWU pk,ptop,kk
      FLOT t,pk
      FREM r,fn,t
       BZ   r,4B
7H    FCMP t,t,sqrtn
       BNN t,2B
8H     INCL kk,2
       JMP  6B
       GREG @
Title  BYTE "First Five Hundred Primes"
NewLn  BYTE #a,0
Blanks BYTE "   ",0
2H     LDA  t,Title
       TRAP 0,Fputs,StdOut
       NEG  mm,2
3H     ADD  mm,mm,j0
       LDA  t,Blanks
       TRAP 0,Fputs,StdOut
2H     LDWU pk,ptop,mm
0H     GREG #2030303030000000
       STOU 0B,BUF
       LDA  t,BUF+4
1H     DIV  pk,pk,10
       GET  r,rR
       INCL r,'0'
       STBU r,t,0
       SUB  t,t,1
       PBNZ pk,1B
       LDA  t,BUF
       TRAP 0,Fputs,StdOut
       INCL mm,2*L/10
       PBN  mm,2B
       LDA  t,NewLn
       TRAP 0,Fputs,StdOut
       CMP  t,mm,2*(L/10-1)
       PBNZ t,3B
       TRAP 0,Halt,0