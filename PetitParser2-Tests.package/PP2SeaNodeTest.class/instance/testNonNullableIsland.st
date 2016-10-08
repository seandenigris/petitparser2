tests
testNonNullableIsland
	| waterToken island beforeWater boundary elements |
	waterToken := #space asPParser.
	island := $a asPParser optional.
	sea := PP2SeaNode new
		island: island;
		waterToken: waterToken;
		yourself.
	boundary := $b asPParser.
		
	parser := sea, boundary.
	
	context := PP2Context new.
	context parser: parser.

	beforeWater := sea createBeforeWater: context.
			
	elements := beforeWater boundary child children.
	self assert: elements size equals: 2.	
	self assert: elements noneSatisfy: [ :e | e isNullable  ].