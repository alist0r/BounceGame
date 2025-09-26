class_name Ball extends State

func run(delta):
	if player_reference.body.is_on_floor() and Input.is_action_pressed("jump"):
		player_reference.body.linear_velocity = Vector2(0,0)
		statemgr.change_state(statemgr.States[statemgr.StateKeys.GROUND])
		player_reference.change_body(player_reference.UprightBodyScene)
		player_reference.body.velocity = Vector2(0,0)
