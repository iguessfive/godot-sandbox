extends Node2D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		# every time clicked a new line_2d will be creates and added to child,
		# is this what you want?
		var line_2d = Line2D.new()
		add_child(line_2d)
		var mouse_click_local_position = line_2d.get_local_mouse_position()
		
