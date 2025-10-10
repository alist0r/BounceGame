extends Area2D

@export var force = 100
@export var x = -2
@export var y = 2
var dir = Vector2(x,y)

func _ready() -> void:
	if x > 0:
		$Arrow.rotation_degrees += 45
	elif x < 0:
		$Arrow.rotation_degrees -= 45


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("dks")
		$"../Player".impulse(dir,force)
