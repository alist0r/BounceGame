class_name State extends Node

var player_reference
var statemgr

func _init(player_reference, statemgr):
	self.player_reference = player_reference
	self.statemgr = statemgr

func change_state_from(from_state):
	pass

func run(delta):
	pass

func state_draw():
	pass
