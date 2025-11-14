class_name Ball extends State

var jump_released

func run(delta) -> void:
	if not Input.is_action_pressed("jump"):
		jump_released = true
	
	if (player_reference.body.is_on_floor() and jump_released \
	and Input.is_action_pressed("jump")) \
	or player_reference.body.linear_velocity == Vector2(0,0) :
		player_reference.body.linear_velocity = Vector2(0,0)
		statemgr.change_state(statemgr.States[statemgr.StateKeys.GROUND])
		player_reference.change_body(player_reference.UprightBodyScene)
		player_reference.body.velocity = Vector2(0,0)
