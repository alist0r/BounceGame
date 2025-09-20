class_name Grounded extends State

var player

func _ready() -> void:
	var player = self.get_parent().get_parent()

func _physics_process(delta) -> void:
	#this if statement is ugly as hell but makes sure the player stops walking
	if Input.is_action_pressed("left") and Input.is_action_pressed("left") \
	or not Input.is_action_pressed("left") and Input.is_action_pressed("right"):
		stand()
	elif Input.is_action_pressed("right"):
		walk(true)
	elif Input.is_action_pressed("left"):
		walk(false)

func walk(is_right: bool):
	if is_right:
		player.velocity.x = 10
	if not is_right:
		player.velocity.x = -10

func stand():
	player.velocity.x = 0
