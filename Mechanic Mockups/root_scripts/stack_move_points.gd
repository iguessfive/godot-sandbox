extends Node2D

var mouse_click_points: Array[Vector2] = []
var is_stacking_on: bool = false

@onready var line_2d: Line2D = $Line2D
@onready var toggle_stacking_points: Button = $CanvasLayer/ToggleStackingPoints
@onready var clear_line: Button = $CanvasLayer/ClearLine

func _ready() -> void:
	toggle_stacking_points.pressed.connect(func():
		is_stacking_on = not is_stacking_on
		)
		
	clear_line.pressed.connect(line_2d.clear_points)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		var mouse_click_point = line_2d.get_local_mouse_position()
		
		if line_2d.points.is_empty():
			const PIXEL_DOT = preload("res://other/ui/visuals/pixel_dot.png")
			var sprite_2d = Sprite2D.new()
			line_2d.add_child(sprite_2d)
			sprite_2d.name = "Start"
			sprite_2d.texture = PIXEL_DOT
			sprite_2d.position = mouse_click_point
		
		if is_stacking_on:
			mouse_click_points.append(mouse_click_point)
			line_2d.add_point(mouse_click_point)
		else:
			var is_second_time: bool = line_2d.get_point_count() == 2
			print(line_2d.get_point_count())
			var single_line_and_remove = (func():
				line_2d.add_point(mouse_click_point)
				var sprite = line_2d.get_node_or_null("Start")
				if sprite != null and is_second_time:
					sprite.queue_free()
				).call()
				
			match is_second_time:
				true: line_2d.clear_points()
				false: single_line_and_remove
			
		
		
