extends Node2D

var StateMgr: StateManager
var old_state: State
var body: PhysicsBody2D
@export var BallBodyScene: PackedScene
@export var UprightBodyScene: PackedScene
var wish_dir = Vector2(0,0)

func _ready():
	StateMgr = StateManager.new(self)
	StateMgr.change_state(StateMgr.States[StateMgr.StateKeys.GROUND])
	change_body(UprightBodyScene)

func _process(delta):
	#print("state:", StateMgr.current_state)
	#print("body:", body)
	wish_dir = Vector2(float(Input.is_action_pressed("right")) - float(Input.is_action_pressed("left")),float(Input.is_action_pressed("down")))
	
	# reduce power to compensate for diagonal angle
	if wish_dir[0] != 0 and wish_dir[1] != 0:
		# this is just how 45 degree angle works i swear
		wish_dir *= 0.7071

func _physics_process(delta):
	if StateMgr.current_state != old_state:
		StateMgr.current_state.change_state_from(old_state)
		old_state = StateMgr.current_state
	StateMgr.current_state.run(delta)

func _draw():
	StateMgr.current_state.state_draw()

func change_body(BodyScene: PackedScene):
	var body_position = self.position
	if (body != null):
		body_position = body.position
		body.queue_free()
	var body_init = BodyScene.instantiate()
	add_child(body_init)
	body = body_init
	body.position = body_position

func impulse(direction: Vector2, force: float) -> void:
	#print(StateMgr.current_state is Ball)
	#print(StateMgr.current_state)
	if body is not RigidBody2D:
		StateMgr.change_state(StateMgr.States[StateMgr.StateKeys.BALL])
		change_body(BallBodyScene)
	assert(StateMgr.current_state is Ball)
	self.body.apply_impulse(direction * Vector2(force,force))
