"
Creates PP2 node from a block. The block has to follow the rules of parser combinators:
- return result or PP2Failure
- no side effects
- return PP2Context to its original position in case of failure

Example:
[ :context | 
	context peek = $a 
	  ifTrue: [ 'CORRECT!' ] 
	  ifFalse: [ PP2Failure message: 'Not good' context: context ] ] asPParser 
parse: 'a'
"
Class {
	#name : #PP2PluggableNode,
	#superclass : #PP2Node,
	#instVars : [
		'block'
	],
	#category : #'PetitParser2-Nodes'
}

{ #category : #'as yet unclassified' }
PP2PluggableNode class >> on: block [
	^ self new
		block: block;
		yourself
]

{ #category : #visiting }
PP2PluggableNode >> accept: aPP2Visitor [
	^ aPP2Visitor visitPluggable: self
]

{ #category : #accessing }
PP2PluggableNode >> block [
	^ block
]

{ #category : #accessing }
PP2PluggableNode >> block: anObject [
	block := anObject
]

{ #category : #accessing }
PP2PluggableNode >> firstCharSet [
	^ PP2UnknownCharSetPredicate instance
]

{ #category : #'analysis - first' }
PP2PluggableNode >> isFirstSetTerminal [
	"lets be conservative here"
	^ true
]

{ #category : #comparing }
PP2PluggableNode >> localEquals: anotherNode [
	(super localEquals: anotherNode) ifFalse: [ ^ false ].
	
	^ (self block printString = anotherNode block printString)
]

{ #category : #comparing }
PP2PluggableNode >> localHash [
	^ super localHash bitXor: self block printString hash
]

{ #category : #'parsing - private' }
PP2PluggableNode >> parseOn: aPP2Context [
	^ strategy parseOn: aPP2Context 
]

{ #category : #initialization }
PP2PluggableNode >> resetStrategy [
	strategy := PP2Pluggable on: self
]
