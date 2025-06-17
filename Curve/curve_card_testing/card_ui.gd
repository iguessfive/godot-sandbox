extends Control

@onready var selected_panel: Panel = %SelectedPanel

func _ready() -> void:
	pass

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		selected_panel.visible = true
	
