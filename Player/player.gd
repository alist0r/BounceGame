extends Node2D

#StateMgr 
var StateMgr: StateManager
var body: Node2D #i know so descriptive very type safe! (dont do this)

func _ready():
	StateMgr = StateManager.new()

func impulse():
	pass


func walk():
	pass
