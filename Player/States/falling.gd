class_name Falling extends State

func run(delta):
	player_reference.body.velocity.y += Global.GRAVETY * delta
	player_reference.body.move_and_slide()
	if player_reference.body.is_on_floor():
		statemgr.change_state(statemgr.States[statemgr.StateKeys.GROUND])
#TODO need to incorperate ball dash
