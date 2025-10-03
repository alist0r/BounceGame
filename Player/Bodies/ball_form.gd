extends RigidBody2D
@export var ABSORBTION = 40

@onready var GroundDetector: ShapeCast2D = $ShapeCast2D

# returns force of 1 in velocity's direction
func magnitude(vec) -> float:
	return ((vec[0] ** 2 + vec[1] ** 2) ** 0.5)

func is_on_floor() -> bool:
	return GroundDetector.is_colliding()


func _on_body_entered(body):
	if magnitude(self.linear_velocity) < ABSORBTION * 2:
		self.linear_velocity = Vector2(0,0)
		return

	# absorb some of the force on bounce
	var absorb_force = (self.linear_velocity / magnitude(self.linear_velocity)) * ABSORBTION	
	if magnitude(self.linear_velocity) > 200: # absorb more on small bounce
		absorb_force = absorb_force * 1.5
	
	
	# if it would turn the ball around, like dont do that please
	if abs(absorb_force[0]) - abs(self.linear_velocity[0]) > 0:
		absorb_force[0] = 0

	print("vel", self.linear_velocity)
	print(self.linear_velocity[0] > 0)
	print("absorb", absorb_force)	
	self.linear_velocity += absorb_force * -1
