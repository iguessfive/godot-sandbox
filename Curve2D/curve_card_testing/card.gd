extends Sprite2D

@export var title := "Gobot 1"

@onready var label: Label = %Label
@onready var ui: Control = %UI

func _ready() -> void:
	label.text = title
