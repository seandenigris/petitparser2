tests
testChoice
	parser := $a asParser2 / $b asParser2.
	children := self visit: parser.
	
	self assert: children isCollection.
	self assert: children size = 3.
	self assert: (children includes: parser).
	self assert: (children includes: parser firstChild).
	self assert: (children includes: parser secondChild).