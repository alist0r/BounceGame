class_name RollOut extends State

var timer

func run(delta):
	player_reference.body.velocity.y += Global.GRAVETY * delta
	player_reference.body.move_and_slide()
	if timer == null:
		timer = Timer.new()
		player_reference.add_child(timer)
		timer.start(0.3)
		await timer.timeout
		statemgr.change_state(statemgr.States[statemgr.StateKeys.GROUND])
		timer.queue_free()
		timer = null
