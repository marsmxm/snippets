[[SET Driver
        LOC Data_Segment
        GREG @
R       [[In]]
	GREG	@
Test    [[Test]]
	GREG	@
O       OCTA 0

Size    IS    [[n]]

        LOC   #100
Main    LDA $2,R
        LDA $3,O
        SET $4,Size
        GET $0,rI
        PUSHJ $1,Merge
        GET $1,rI

        [[Runtime]]
        [[COMMENT Compare]]
        
        SET $255,0
        TRAP 0,Halt,0
        
[[INCLUDE merge.mms]]
[[INCLUDE print.mms]]
]]

[[SET Runtime %]]

[[SET Compare
        SET   $7,Size
        ADD   $7,$7,1
        SLU   $7,$7,3
        LDA   $2,R
        SUB   $2,$2,8
        LDA   $3,O
        ADD   $7,$7,$3
        SET   $8,0
        SET   $5,0
        JMP   8F
7H      LDO   $6,$2,$8
        STO   $6,$3,$5
        ADD   $5,$5,8
8H      LDO   $8,$7,$8
        PBNZ  $8,7B
        [[INCLUDE OctaEqual.mms O Test Size]]
]]


[[TEST 1]]
    [[SET In  OCTA 5,0]]
    [[SET Test OCTA 5,0]]
    [[SET n 1]]
    [[Driver]]
[[END 1]]

[[TEST 2]]
    [[SET In OCTA 5,2,0]]
    [[SET Test OCTA 2,5,0]]
    [[SET n 2]]
    [[Driver]]
[[END 2]]

[[TEST 3]]
    [[SET In OCTA 2,5,0]]
    [[SET Test OCTA 2,5,0]]
    [[SET n 2]]
    [[Driver]]
[[END 3]]

[[TEST 4]]
    [[SET In OCTA 3,2,5,0]]
    [[SET Test OCTA 2,3,5,0]]
    [[SET n 3]]
    [[Driver]]
[[END 4]]

[[TEST 5]]
    [[SET In OCTA 5,3,2,5,0]]
    [[SET Test OCTA 2,3,5,5,0]]
    [[SET n 4]]
    [[Driver]]
[[END 5]]

[[TEST 6]]
    [[SET In OCTA 5,3,2,5,7,11,-3,2,99,5,0]]
    [[SET Test OCTA -3,2,2,3,5,5,5,7,11,99,0]]
    [[SET n 10]]
    [[Driver]]
[[END 6]]

[[COMMENT Table 1 on page 81 and Fig 14 on page 106]]
[[TEST 7]]
    [[SET In OCTA 503,087,512,061,908,170,897,275
        OCTA 653,426,154,509,612,677,765,703,0]]
    [[SET Test OCTA 061,087,154,170,275,426,503,509
        OCTA 512,612,653,677,703,765,897,908,0]]
    [[SET n 16]]
    [[SET Runtime [[INCLUDE runtime.mms $0 $1 835 5]]]]
    [[Driver]]
[[END 7]]

[[COMMENT 1000 random values]]
[[TEST 8]]
    [[SET In [[INCLUDE s1000.mms]]]]
    [[SET Test [[INCLUDE s1000s.mms]]]]
    [[SET n 1000]]
    [[SET Runtime [[INCLUDE runtime.mms $0 $1 116430 5]]]]
    [[Driver]]
[[END 8]]