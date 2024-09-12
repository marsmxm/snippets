[[TEST 1]]


	LOC	#100

	[[INCLUDE ex1.mms]]


	PREFIX	:
Main	IS	@
	
	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 1 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 2 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 2 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 7 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 8 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 2 ]]
	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 9 ]]
	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 9 ]]
	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 1 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 2 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 7 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 6 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 3 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 10 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 5 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 5 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 9 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 8 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 10 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 2 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 9 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 3 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 3 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 6 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 10 ]]


	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 1 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 2 ]]

	SET	$1,10
	PUSHJ	$0,RandInt

	[[INCLUDE expect.mms "X" $0 4 ]]


	SET	$255,0
	TRAP	0,Halt,0

[[INCLUDE print.mms]]

[[END 1]]


	