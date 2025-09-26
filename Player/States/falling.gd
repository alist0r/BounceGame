class_name Falling extends State

func run(delta):
	player_reference.body.velocity.y += Global.GRAVETY * delta
	player_reference.body.move_and_slide()
	if player_reference.body.is_on_floor():
		statemgr.change_state(statemgr.States[statemgr.StateKeys.GROUND])
	if Input.is_action_just_pressed("jump"):
		statemgr.change_state(statemgr.States[statemgr.StateKeys.BALL])
#TODO need to change to splat depending on velocity
#TODO need to set max velocity (probably in a script for the actual body)
#TODO incorperate some kind of slight air influence
