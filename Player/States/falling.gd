class_name Falling extends State

const DASH_SPEED = 700

func run(delta):
	player_reference.body.velocity.y += Global.GRAVETY * delta
	player_reference.body.move_and_slide()
	if player_reference.body.is_on_floor():
		statemgr.change_state(statemgr.States[statemgr.StateKeys.GROUND])
	if Input.is_action_just_pressed("jump"):
		player_reference.impulse(player_reference.wish_dir, DASH_SPEED)
#TODO need to change to splat depending on velocity
#TODO need to set max velocity (probably in a script for the actual body)
#TODO incorperate some kind of slight air influence
