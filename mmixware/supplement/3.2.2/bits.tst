[[TEST 1]]


	LOC	#100

%%%x	GREG	1
%%%a	GREG	(1<<55)+(1<<24)+1

x	GREG	(8+2+1)<<60
a	GREG	(2+1)<<60


	PREFIX	:
Main	IS	@
	%% from Fig 1. page 31
	
	[[INCLUDE bits.mms]]
	[[INCLUDE expect.mms "bits" :x ((4+1)<<60)]]
	[[INCLUDE bits.mms]]
	[[INCLUDE expect.mms "bits" :x ((8+2)<<60)]]
	[[INCLUDE bits.mms]]
	[[INCLUDE expect.mms "bits" :x ((4+2+1)<<60)]]
	[[INCLUDE bits.mms]]
	[[INCLUDE expect.mms "bits" :x ((8+4+2)<<60)]]
	[[INCLUDE bits.mms]]
	[[INCLUDE expect.mms "bits" :x ((8+4+2+1)<<60)]]
	[[INCLUDE bits.mms]]
	[[INCLUDE expect.mms "bits" :x ((8+4+1)<<60)]]
	[[INCLUDE bits.mms]]
	[[INCLUDE expect.mms "bits" :x ((8+1)<<60)]]
	[[INCLUDE bits.mms]]
	[[INCLUDE expect.mms "bits" :x ((1)<<60)]]
	[[INCLUDE bits.mms]]
	[[INCLUDE expect.mms "bits" :x ((2)<<60)]]
	[[INCLUDE bits.mms]]
	[[INCLUDE expect.mms "bits" :x ((4)<<60)]]
	[[INCLUDE bits.mms]]
	[[INCLUDE expect.mms "bits" :x ((8)<<60)]]
	[[INCLUDE bits.mms]]
	[[INCLUDE expect.mms "bits" :x ((2+1)<<60)]]
	[[INCLUDE bits.mms]]
	[[INCLUDE expect.mms "bits" :x ((4+2)<<60)]]
	[[INCLUDE bits.mms]]
	[[INCLUDE expect.mms "bits" :x ((8+4)<<60)]]
	[[INCLUDE bits.mms]]
	[[INCLUDE expect.mms "bits" :x ((8+2+1)<<60)]]





	SET	$255,0
	TRAP	0,Halt,0

[[INCLUDE print.mms]]

[[END 1]]


	