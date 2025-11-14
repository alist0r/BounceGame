extends Node2D

var StateMgr: StateManager
var body: PhysicsBody2D
@export var BallBodyScene: PackedScene
@export var UprightBodyScene: PackedScene
var wish_dir = Vector2(0,0)

func _ready():
	StateMgr = StateManager.new(self)
	StateMgr.change_state(StateMgr.States[StateMgr.StateKeys.GROUND])
	change_body(UprightBodyScene)

func _process(delta):
	wish_dir = (Vector2(float(Input.is_action_pressed("right")) - float(Input.is_action_pressed("left")),float(Input.is_action_pressed("down")))).normalized()

func _physics_process(delta):
	StateMgr.current_state.run(delta)

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
	if body is not RigidBody2D:
		StateMgr.change_state(StateMgr.States[StateMgr.StateKeys.BALL])
		change_body(BallBodyScene)
	assert(StateMgr.current_state is Ball)
	self.body.apply_impulse(direction * Vector2(force,force))
