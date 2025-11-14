class_name Falling extends State
var physmgr: Physics_Prediction
const SLOWDOWN = 5
const DASH_SPEED = 1000
var second_press
var release

func _init(a, b):
	super(a, b)
	physmgr = Physics_Prediction.new(self)
	player_reference.add_child(physmgr)

func run(delta):
	if !Input.is_action_pressed("jump"):
		release = true
	if release:
		if Input.is_action_pressed("jump"):
			second_press = true
	if second_press:
		player_reference.body.velocity /= SLOWDOWN
	else:
		player_reference.body.velocity.y += Global.GRAVETY * delta

	player_reference.body.move_and_slide()

	# give back the player's velocity
	if second_press:
		player_reference.body.velocity = player_reference.body.velocity * SLOWDOWN

	if player_reference.body.is_on_floor():
		statemgr.change_state(statemgr.States[statemgr.StateKeys.GROUND])
	if Input.is_action_just_released("jump") and second_press:
		release = false
		second_press = false
		player_reference.impulse(player_reference.wish_dir, DASH_SPEED)
	physmgr.queue_redraw()
	
	
	
#TODO need to change to splat depending on velocity
#TODO need to set max velocity (probably in a script for the actual body)
#TODO incorperate some kind of slight air influence
