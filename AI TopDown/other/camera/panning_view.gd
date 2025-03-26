extends Camera2D

@export var pannning_speed: float = 180.0

func _process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	position += direction * delta * 180.0
