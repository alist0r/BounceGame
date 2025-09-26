class_name Grounded extends State

const WALK_SPEED = 200

func _init(player_reference, statemgr) -> void:
	super(player_reference, statemgr)

func run(delta) -> void:
	#this if statement is ugly as hell but makes sure the player stops walking
	walk(delta)
	if Input.is_action_just_pressed("jump"):
		jump()
	self.player_reference.body.move_and_slide()
	if not self.player_reference.body.is_on_floor():
		statemgr.change_state(statemgr.States[statemgr.StateKeys.FALL])

#TODO speed ramping
func walk(delta):
	self.player_reference.body.velocity.x = self.player_reference.wish_dir.x * WALK_SPEED

#TODO dynamic jumping
func jump():
	self.player_reference.body.velocity.y = -700
