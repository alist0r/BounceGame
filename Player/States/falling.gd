class_name Falling extends State

const DASH_SPEED = 1000
const SLOWDOWN = 10 # must be integer, fraction of original speed
var falling_frames = 0
var fall_time = 0
var slow_gravity

func _init(player_reference, statemgr):
	self.player_reference = player_reference
	self.statemgr = statemgr

func is_holding_dash():
	return Input.is_action_pressed("down") or Input.is_action_pressed("right") or Input.is_action_pressed("left")

func run(delta):
	falling_frames = falling_frames + 1
	
	if is_holding_dash():
		player_reference.body.velocity /= SLOWDOWN
		if falling_frames % SLOWDOWN == 0:
			slow_gravity = (Global.GRAVETY * delta / SLOWDOWN) * 1.05
			player_reference.body.velocity.y += slow_gravity
	else:
		player_reference.body.velocity.y += Global.GRAVETY * delta

	player_reference.body.move_and_slide()

	# give back the player's velocity
	if is_holding_dash():
		player_reference.body.velocity = player_reference.body.velocity * 10

	if player_reference.body.is_on_floor():
		statemgr.change_state(statemgr.States[statemgr.StateKeys.GROUND])
	if Input.is_action_just_pressed("jump"):
		player_reference.impulse(player_reference.wish_dir, DASH_SPEED)
		
#TODO need to change to splat depending on velocity
#TODO need to set max velocity (probably in a script for the actual body)
#TODO incorperate some kind of slight air influence
