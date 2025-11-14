class_name Physics_Prediction extends Node2D

@export var ABSORBTION = 40
@export var ABSORBTION_MULT = 1.5
@export var EXTRA_ABSORBTION_THRESHOLD = 200

const SIMULATION_FRAMERATE = 480
const SIMULATION_TIME = 0.5
const SIMULATION_DOTS_PER_SECOND = 30
const DAMPENING = 0.25
const MAX_BOUNCE_SIM = 5
var physics_point_list = []
var hit_points = []
var parent

func _init(parent):
	self.parent = parent

func physics_predict(start_pos):
	var pos = start_pos
	var vel = parent.player_reference.wish_dir * parent.DASH_SPEED
	var bounces = 0
	
	for tick in range(SIMULATION_TIME * SIMULATION_FRAMERATE):
		pos = pos + vel/SIMULATION_FRAMERATE
		vel *= 1 - 1/SIMULATION_FRAMERATE * DAMPENING
		vel.y += Global.GRAVETY/SIMULATION_FRAMERATE
		if tick % (SIMULATION_FRAMERATE / SIMULATION_DOTS_PER_SECOND) == 0:
			physics_point_list += [pos]
		
		# for some reason it offsets by player reference position. idk bro.
		var offset = parent.player_reference.position
		var hit = simulate_ball_collision(pos + offset)
		
		if hit:
			hit_points = hit_points + [hit[0] - offset]
		if hit and bounces >= MAX_BOUNCE_SIM:
			return
		elif hit:
			bounces += 1
			
			# formula for reflection:
			# r=d−2(d⋅n)n
			var normal_vector = (pos - hit[0] + offset).normalized()

			#pos = hit[0] - offset + 20 * normal_vector 
			vel = vel - 2*(vel.dot(normal_vector)) * normal_vector
			
			if vel.dot(vel) < ABSORBTION * ABSORBTION_MULT:
				self.linear_velocity = Vector2(0,0)
				return

			# absorb some of the force on bounce
			var absorb_force = (vel / vel.dot(vel)) * ABSORBTION	
			if vel.dot(vel) > EXTRA_ABSORBTION_THRESHOLD: # absorb more on small bounce
				absorb_force = absorb_force * ABSORBTION_MULT
			
			# if it would turn the ball around, like dont do that please
			if abs(absorb_force[0]) - abs(vel[0]) > 0:
				absorb_force[0] = 0

			# apply force
			vel += absorb_force * -1

func simulate_ball_collision(pos):
	var space_state = parent.player_reference.body.get_world_2d().direct_space_state
	
	var params = PhysicsShapeQueryParameters2D.new()
	var area = CircleShape2D.new()
	
	area.radius = 20
	
	params.exclude = [parent.player_reference.body.get_rid()] # exclude the player in detection
	params.shape = area
	# move shape into position
	params.transform = Transform2D(0, pos)
	
	var result = space_state.collide_shape(params, 1)
	if result == []: return false
	return result

func _draw():
	print("here")
	physics_point_list = []
	hit_points = []
	if parent.second_press:
		physics_predict(parent.player_reference.body.position)
		print(physics_point_list)
	for point in range(len(physics_point_list)):
		var clr = 1 - (0.5 * point)/len(physics_point_list)
		draw_circle(physics_point_list[point], 3, Color(1,1,1,clr), true)

	for point in range(len(hit_points)):
		draw_circle(hit_points[point], 6, Color(1,1,1), true)
