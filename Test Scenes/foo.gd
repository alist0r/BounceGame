extends Area2D


func _on_body_entered(body):
	if body.get_parent() is Player:
		body.get_parent().impulse(Vector2(2,2), 100)
