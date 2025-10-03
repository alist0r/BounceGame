extends Area2D

# tells Godot to assign colShp after the node (& children) is added to the scene tree
@onready var colShp = $CollisionShape2D #

func _ready():
	colShp.disabled = true # Collision shape not active

#func _process(delta: float) -> void:
	

func _activateCollShape():
	colShp.disabled = false # Collision shape is active
