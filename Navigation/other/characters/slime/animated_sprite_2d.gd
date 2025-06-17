extends AnimatedSprite2D

var _owner: CharacterBody2D 

func _init() -> void:
	set_process(false)

func _ready() -> void:
	if get_owner() is CharacterBody2D:
		_owner = get_owner()
		
	ready.connect(func():
		var is_valid: bool =  _owner != null and sprite_frames != null
		if is_valid:
			set_process(true)
		else:
			assert(is_valid, "_owner may not be `CharacterBody2D` or sprite frames may be null")
	)

func _process(_delta: float) -> void:
	var direction = _owner.velocity.sign()
	
	match direction:
		Vector2.LEFT:
			play("move_left")
		Vector2.RIGHT:
			play("move_right")
		Vector2.UP, Vector2.UP + Vector2.RIGHT, Vector2.UP + Vector2.LEFT:
			play("move_up")
		Vector2.DOWN, Vector2.DOWN + Vector2.RIGHT, Vector2.DOWN + Vector2.LEFT:
			play("move_down")
		_:
			stop()
