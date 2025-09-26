extends RigidBody2D

@onready var GroundDetector: ShapeCast2D = $ShapeCast2D

func is_on_floor() -> bool:
	return GroundDetector.is_colliding()
