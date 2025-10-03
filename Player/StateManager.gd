class_name StateManager

enum StateKeys {BALL, FALL, GROUND, SPLAT}
var current_state = null
var States: Array = []

func _init(player_reference): #init happens when instantiated rather then when node is 'ready'
	States.push_back(preload("res://Player/States/ball.gd").new(player_reference, self))
	States.push_back(preload("res://Player/States/falling.gd").new(player_reference, self))
	States.push_back(preload("res://Player/States/grounded.gd").new(player_reference, self))
	States.push_back(preload("res://Player/States/splat.gd").new(player_reference, self))

func change_state(new_state: State) -> void:
	self.current_state = new_state
