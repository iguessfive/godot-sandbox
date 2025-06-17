extends Node2D

const SELECT_RING = preload("res://other/ui/visuals/select_ring.png")

var selected_character: CharacterBody2D: set = set_selected_character
var is_moving_enabled: bool = false

@onready var selected_character_label: Label = %SelectedCharacterLabel
@onready var toggle_move: Button = %ToggleMove

func _ready() -> void:
	toggle_move.pressed.connect(func():
		is_moving_enabled = not is_moving_enabled
		var fox_characters_in_scene = get_tree().get_nodes_in_group("fox")
		for fox in fox_characters_in_scene:
			if is_moving_enabled:
				fox.set_physics_process(true)
			else:
				fox.set_physics_process(false)
	)
	%ToggleMoveCombo.pressed.connect(
		func():
			if selected_character == null:
				return 
			var is_move_stacking = (selected_character as Fox).is_move_stacking_enabled
			is_move_stacking = not is_move_stacking
			(selected_character as Fox).is_move_stacking_enabled = is_move_stacking
	)

func set_selected_character(new_character: CharacterBody2D) -> void:
	selected_character = new_character
	selected_character_label.text = selected_character.name
	
	selected_character.unselected.connect(func():
		selected_character_label.text = "empty"
		)
	
	var selection_ring = Sprite2D.new()
	selection_ring.name = "Selector"
	selected_character.add_child(selection_ring)
	selection_ring.texture = SELECT_RING
	selection_ring.global_position = selected_character.global_position
