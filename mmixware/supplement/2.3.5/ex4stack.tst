[[SET DRIVER

        LOC Data_Segment+0
        GREG @
P0      [[P0]]
        GREG @
Expect  [[Expect]]

        LOC #100
        GREG @
        
        [[INCLUDE compare.mms]]

        [[INCLUDE ex4stack.mms]]
        
Main    LDA $1,P0
        PUSHJ $0,Mark
        
        LDA $1,P0
        LDA $2,Expect
        SET $3,[[Octas]]
        PUSHJ $0,:Compare:Octa
        
        SET $255,0
        TRAP
]]

[[COMMENT /!\ ATTENTION /!\ ACHTUNG /!\
    In all the tests, we assume that the structure is based at location
    Data_Segment+0 = #2000000000000000.
]]

[[TEST 1]]
[[COMMENT Topology: one atom only, thus {A|B}LINKs contain pointers to
some data in memory. They are then aligned addresses.

                    [atom]

]]
[[SET P0     OCTA #3000000000000011,#3000000000000040]]
[[SET Expect OCTA #3000000000000013,#3000000000000040]]
[[SET Octas 2]]
[[DRIVER]]
[[END 1]]

[[TEST 2]]
[[COMMENT Topology: one node only, thus {A|B}LINKs contain null
pointers.

                    (node)
                    /    \
                  NULL  NULL

]]
[[SET P0     OCTA #0000000000000000,#0000000000000000]]
[[SET Expect OCTA #0000000000000002,#0000000000000000]]
[[SET Octas 2]]
[[DRIVER]]
[[END 2]]

[[TEST 3]]
[[COMMENT Topology: one node only with a left atom.

                    (node)
                    /    \
                 [atom]  NULL

]]
[[SET P0     OCTA #2000000000000010,#0000000000000000
             OCTA #3000000000000231,#3000000003400050
]]
[[SET Expect OCTA #2000000000000012,#0000000000000000
             OCTA #3000000000000233,#3000000003400050
]]
[[SET Octas 4]]
[[DRIVER]]
[[END 3]]

[[TEST 4]]
[[COMMENT Topology: one node only with a right atom.

                    (node)
                    /    \
                  NULL  [atom]

]]
[[SET P0     OCTA #0000000000000000,#2000000000000010
             OCTA #3000000003565379,#3000350008ED0050
]]
[[SET Expect OCTA #0000000000000002,#2000000000000010
             OCTA #300000000356537B,#3000350008ED0050
]]
[[SET Octas 4]]
[[DRIVER]]
[[END 4]]

[[TEST 5]]
[[COMMENT Topology: one node only with two atoms.

                    (node)
                    /    \
                 [atom] [atom]

]]
[[SET P0     OCTA #2000000000000010,#2000000000000020
             OCTA #3123456789ABCDE9,#3000000EEEEEEEE0
             OCTA #3FFFFFFFFFFFFFF1,#3AAAABBBCCCCDDD8
]]
[[SET Expect OCTA #2000000000000012,#2000000000000020
             OCTA #3123456789ABCDEB,#3000000EEEEEEEE0
             OCTA #3FFFFFFFFFFFFFF3,#3AAAABBBCCCCDDD8
]]
[[SET Octas 6]]
[[DRIVER]]
[[END 5]]

[[TEST 6]]
[[COMMENT Topology: complex. Taken from fig.39, page 419. Unused nodes
are also sprayed in memory.

                    ( a )
                    /   \
                 [ b ]-( c )<----\
                           \      \
                          ( d )\   \
                           / \_/   /
                        ( e )     /
                           \_____/

]]
[[SET P0     OCTA #2000000000000080,#2000000000000020 % node a
             OCTA #6000000000000000,#6000000000000000 % unused
             OCTA #2000000000000080,#2000000000000030 % node c
             OCTA #2000000000000060,#2000000000000030 % node d
             OCTA #6000000000000000,#6000000000000000 % unused
             OCTA #6000000000000000,#6000000000000000 % unused
             OCTA #0000000000000000,#2000000000000020 % node e
             OCTA #6000000000000000,#6000000000000000 % unused
             OCTA #3ABCDEFFFFFFFFF9,#3FEDCBAAAAAAAAA0 % atom b
]]
[[SET Expect OCTA #2000000000000082,#2000000000000020 % node a
             OCTA #6000000000000000,#6000000000000000 % unused
             OCTA #2000000000000082,#2000000000000030 % node c
             OCTA #2000000000000062,#2000000000000030 % node d
             OCTA #6000000000000000,#6000000000000000 % unused
             OCTA #6000000000000000,#6000000000000000 % unused
             OCTA #0000000000000002,#2000000000000020 % node e
             OCTA #6000000000000000,#6000000000000000 % unused
             OCTA #3ABCDEFFFFFFFFFB,#3FEDCBAAAAAAAAA0 % atom b
]]
[[SET Octas 18]]
[[DRIVER]]
[[END 6]]


