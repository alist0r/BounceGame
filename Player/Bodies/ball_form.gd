extends RigidBody2D
@export var ABSORBTION = 40
@export var ABSORBTION_MULT = 1.5
@export var EXTRA_ABSORBTION_THRESHOLD = 200

@onready var GroundDetector: ShapeCast2D = $ShapeCast2D

# look it's vector calculus it does magnitude thing
func magnitude(vec) -> float:
	return ((vec[0] ** 2 + vec[1] ** 2) ** 0.5)

func is_on_floor() -> bool:
	return GroundDetector.is_colliding()

# to do: care about angle of attack and of hit surface
func _on_body_entered(body):
	# if not going fast enough, just absorb all force
	if magnitude(self.linear_velocity) < ABSORBTION * ABSORBTION_MULT:
		self.linear_velocity = Vector2(0,0)
		return

	# absorb some of the force on bounce
	var absorb_force = (self.linear_velocity / magnitude(self.linear_velocity)) * ABSORBTION	
	if magnitude(self.linear_velocity) > EXTRA_ABSORBTION_THRESHOLD: # absorb more on small bounce
		absorb_force = absorb_force * ABSORBTION_MULT
	
	
	# if it would turn the ball around, like dont do that please
	if abs(absorb_force[0]) - abs(self.linear_velocity[0]) > 0:
		absorb_force[0] = 0

	# apply force
	self.linear_velocity += absorb_force * -1
