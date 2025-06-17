extends CharacterBody2D

var speed: float = 100.0

func _physics_process(_delta: float) -> void:
	var move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = move_direction * speed
	move_and_slide()
