[[SET Driver



       LOC	#100
[[INCLUDE print.mms]]
[[INCLUDE ex14opt.mms]]

	  PREFIX	:

Data	  [[Data]]
Dbase	  GREG		Data-([[from]]*3*8)

y	  IS		$0
last	  IS		$1
before	  IS		$2
after	  IS		$4
yy	  IS		$5
d	  IS		$6
test	  IS		$7
t	  IS		$8
Rtotal	  GREG		0

Main 	  SET		y,[[from]]
	  SET		last,[[to]]
1H	  SET		t+1,y
	  GET		before,rI
	  PUSHJ		t,:Easter
	  GET		after,rI
	  SUB		after,before,after
	  SUB		after,after,5		compensate GET PUSHJ POP
	  ADD		Rtotal,Rtotal,after

	  [[Print]]

	  [[Verify]]	  

	  ADD		y,y,1
	  CMP		t,y,last
	  PBNP		t,1B

	  [[Runtime]]

OK	  SET		$255,0
	  TRAP		0,Halt,0

Fail	  SET		$255,1
	  TRAP		0,Halt,0


]]

[[SET Runtime
          SET     $0,0
          [[INCLUDE runtime.mms :Rtotal $0 [[time]] 0]]
]]

[[SET Print
	  [[printi	t]]
	  [[printc	',']]
	  [[printi	t+1]]
	  [[printc	',']]
	  [[printi	y]]
	  [[printnl]]
]]

[[SET Data
      OCTA	9,4,1950
      OCTA	25,3,1951
      OCTA	13,4,1952
      OCTA	5,4,1953
      OCTA	18,4,1954
      OCTA	10,4,1955
      OCTA	1,4,1956
      OCTA	21,4,1957
      OCTA	6,4,1958
      OCTA	29,3,1959
      OCTA	17,4,1960
      OCTA	2,4,1961
      OCTA	22,4,1962
      OCTA	14,4,1963
      OCTA	29,3,1964
      OCTA	18,4,1965
      OCTA	10,4,1966
      OCTA	26,3,1967
      OCTA	14,4,1968
      OCTA	6,4,1969
      OCTA	29,3,1970
      OCTA	11,4,1971
      OCTA	2,4,1972
      OCTA	22,4,1973
      OCTA	14,4,1974
      OCTA	30,3,1975
      OCTA	18,4,1976
      OCTA	10,4,1977
      OCTA	26,3,1978
      OCTA	15,4,1979
      OCTA	6,4,1980
      OCTA	19,4,1981
      OCTA	11,4,1982
      OCTA	3,4,1983
      OCTA	22,4,1984
      OCTA	7,4,1985
      OCTA	30,3,1986
      OCTA	19,4,1987
      OCTA	3,4,1988
      OCTA	26,3,1989
      OCTA	15,4,1990
      OCTA	31,3,1991
      OCTA	19,4,1992
      OCTA	11,4,1993
      OCTA	3,4,1994
      OCTA	16,4,1995
      OCTA	7,4,1996
      OCTA	30,3,1997
      OCTA	12,4,1998
      OCTA	4,4,1999
      OCTA	23,4,2000
]]

[[SET Verify 
      SL     yy,y,3
      2ADDU  yy,yy,yy
      LDO    d,Dbase,yy
      CMP    test,d,t
      BNZ    test,Fail 
      ADD    yy,yy,8
      LDO    d,Dbase,yy
      CMP    test,d,t+1
      BNZ    test,Fail 
      ADD    yy,yy,8
      LDO    d,Dbase,yy
      CMP    test,d,y
      BNZ    test,Fail 
]]

[[TEST 1]]
[[ verification but no runtime check ]]
[[SET Print % ]]
[[SET from 1950]]
[[SET to   2000]]
[[SET time 17206]]
[[SET Runtime %]]
[[Driver]]

[[END 1]]

[[TEST 2]]
[[ no verification but runtime check ]]
[[SET Print % ]]
[[SET Verify % ]]
[[SET from 1001]]
[[SET to   2000]]
[[SET time 122420]]
[[Driver]]

[[END 2]]

