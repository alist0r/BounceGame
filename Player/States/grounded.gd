class_name Grounded extends State

const WALK_SPEED = 2000

func _init(player_reference, statemgr) -> void:
	super(player_reference, statemgr)

func run(delta) -> void:
	#this if statement is ugly as hell but makes sure the player stops walking
	if Input.is_action_pressed("left") and Input.is_action_pressed("right") \
	or not Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		stand()
	elif Input.is_action_pressed("right"):
		walk(true, delta)
	elif Input.is_action_pressed("left"):
		walk(false, delta)
	self.player_reference.body.move_and_slide()
	if Input.is_action_pressed("jump"):
		jump()
	if not self.player_reference.body.is_on_floor():
		statemgr.change_state(statemgr.States[statemgr.StateKeys.FALL])

func walk(is_right: bool, delta):
	if is_right:
		self.player_reference.body.velocity.x = WALK_SPEED * delta
	if not is_right:
		self.player_reference.body.velocity.x = -WALK_SPEED * delta

func stand():
	self.player_reference.body.velocity.x = 0

#TODO dynamic jumping
func jump():
	self.player_reference.body.velocity.y = -700
