extends CharacterBody2D

# create a way to change the selected node to move with another and move it
# also have a toggle feature that leads to move stacking, like add a array of point that
# player has clicked to move to

@export var speed = 100.0
@warning_ignore("unused_signal")
signal unselected

var is_selected: bool = true 
@warning_ignore("unused_private_class_variable")
var _move_direction := Vector2.ZERO
@warning_ignore("unused_private_class_variable")
var _move_distance := 0.0
@warning_ignore("unused_private_class_variable")
var _current_distance := 0.0

@warning_ignore("unused_variable")
var next_move_point: Vector2 = Vector2.ZERO

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
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
