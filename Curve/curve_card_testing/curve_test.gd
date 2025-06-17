extends Node2D

const CURVE_EXAMPLE = preload("res://curve_example.tres")

var x_value := 0.5

@onready var card: Sprite2D = %Card

var is_check: bool = true

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	var y_value_at_x_offset 

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if is_check:
			print(card.position)

func _create_curve():
	var curve = Curve.new()
	
