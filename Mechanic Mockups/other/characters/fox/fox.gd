class_name Fox extends CharacterBody2D

# click and move character to mouse cursor
# add a line for visual represnetation

# create a way to change the selected node to move with another and move it
# also have a toggle feature that leads to move stacking, like add a array of point that
# player has clicked to move to

@export var speed = 100.0

const SCRIPT = preload("res://example_scenes/fox.gd")

signal unselected

var is_selected: bool = false
var is_move_stacking_enabled: bool = false

var _move_points: Array[Vector2] = []

var _move_direction := Vector2.ZERO
var _move_distance := 0.0
var _current_distance := 0.0

var _final_point: Vector2 = Vector2.ZERO

@onready var _line_2d: Line2D = %Line2D
@onready var selecting_sprite_area: Area2D = %SelectingSpriteArea

func _ready() -> void:
	@warning_ignore("unused_parameter")
	selecting_sprite_area.input_event.connect(func(viewport: Node, event: InputEvent, shape_idx: int): 
		if event.is_action_pressed("left_click"):
			if owner.has_method("set_selected_character"):
				if not is_selected:
					owner.set_selected_character(self)
				is_selected = true
		)

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	if not is_selected: 
		return
	
	var desired_velocity: Vector2 = _move_direction * speed
	
	if velocity.length() > 0:
		_current_distance += speed * delta
		_line_2d.clear_points()
		_line_2d.add_point(_line_2d.position)
		_line_2d.add_point(_final_point * (1 - _current_distance / _move_distance))
	else:
		_current_distance = 0.0
		_line_2d.clear_points()
	
	if _current_distance >= _move_distance:
		velocity = Vector2.ZERO
		_move_direction = Vector2.ZERO
	
	velocity = desired_velocity
	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("right_click"):
		is_selected = false
		var selector = self.get_node_or_null("Selector")
		if selector != null:
			selector.queue_free()
			unselected.emit()
			_line_2d.clear_points()
	
	if event.is_action_pressed("left_click") and is_selected:
		reset_move_data()
		
		if not is_move_stacking_enabled:
		# all movement is handled here
			_move_direction = global_position.direction_to(get_global_mouse_position())
			_move_distance = global_position.distance_to(get_global_mouse_position())
			_final_point = get_local_mouse_position()
		else:
			move_and_update_in_combo_points()
		
func reset_move_data():
	_current_distance = 0.0
	velocity = Vector2.ZERO
	_move_direction = Vector2.ZERO
	
func move_and_update_in_combo_points() -> void:
	if not is_move_stacking_enabled and _move_points.is_empty():
		return
	
	_final_point = get_local_mouse_position()
	_move_points.push_back(_final_point)

	var move_position = _move_points.pop_front()
	_move_points.push_back(_final_point)
	_move_direction = global_position.direction_to(move_position)
	_move_distance = global_position.distance_to(move_position)
	
	for points in _move_points:
		_line_2d.add_point(points)
	
	if _current_distance >= _move_distance:
		reset_move_data()
	
	print(_move_points)
