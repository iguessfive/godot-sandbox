extends Camera2D

@export var direction_speed: float = 480.0

func _init() -> void:
	visible = true

func _process(delta: float) -> void:
	var x_direction = Input.get_axis("move_left", "move_right")
	var y_direction = Input.get_axis("move_up", "move_down")
	var direction: Vector2 = Vector2(x_direction, y_direction).normalized()
	
	position += direction * direction_speed * delta
	
	var x_viewport_half := get_viewport_rect().size.x / 2
	var y_viewport_half := get_viewport_rect().size.y / 2 
	position.x = clamp(position.x, limit_left + x_viewport_half, limit_right - x_viewport_half)
	position.y = clamp(position.y, limit_top + y_viewport_half, limit_bottom - y_viewport_half)
	
