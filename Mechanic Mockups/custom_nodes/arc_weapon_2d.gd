extends Node2D

const Arc := preload("res://custom_nodes/arc_2d.gd")

@export var target: Node2D = null

@onready var _timer: Timer = $Timer

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	if target == null:
		return
	
	if Input.is_action_pressed("shoot") and _timer.is_stopped():
		shoot()

func shoot() -> void:
	_timer.start()
	var arc: Arc = preload("res://custom_nodes/arc_2d.tscn").instantiate()
	add_child(arc)
	arc.global_transform = global_transform
	arc.fire(target.global_position)
	
