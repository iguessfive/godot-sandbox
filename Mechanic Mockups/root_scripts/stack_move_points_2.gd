extends Node2D

var travel_points: Callable = (func():
	var line_2d = Line2D.new()
	line_2d.tree_entered.connect(func():
		start_point_at_fox_global_position()
	)
	return line_2d
)
var is_stacking_click_points_enabled: bool = false
var mouse_click_point_queue: Array[Vector2] = []
var mouse_click_local_position: Vector2

var _travel_point_instance: Line2D

@onready var toggle_stacking_points: Button = $CanvasLayer/ToggleStackingPoints
@onready var clear_line: Button = $CanvasLayer/ClearLine
@onready var fox: Fox = $Fox # this is a node

func start_point_at_fox_global_position():
	if _travel_point_instance.is_visible_in_tree():
		_travel_point_instance.add_point(_travel_point_instance.to_local(fox.global_position))

func _init() -> void:
	_travel_point_instance = travel_points.call()
	
func _ready() -> void:
	add_child(_travel_point_instance)
	clear_line.pressed.connect(clear_line_by_replacing)
	
	toggle_stacking_points.pressed.connect(func():
		is_stacking_click_points_enabled = not is_stacking_click_points_enabled
		print(is_stacking_click_points_enabled)
	)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		if not _travel_point_instance.is_visible_in_tree():
			return
		
		if not is_stacking_click_points_enabled:
			if _travel_point_instance.get_point_count() > 1:
				clear_line_by_replacing()
				
		mouse_click_local_position = _travel_point_instance.get_local_mouse_position()
		_travel_point_instance.add_point(mouse_click_local_position)
		
		# data structure
		if is_stacking_click_points_enabled:
			mouse_click_point_queue.push_back(mouse_click_local_position)
		
func clear_line_by_replacing():
		if _travel_point_instance == null:
			return
		
		if has_node(_travel_point_instance.get_path()):
			_travel_point_instance.queue_free()
		_travel_point_instance = travel_points.call()
		add_child(_travel_point_instance)
		
		
		
		
