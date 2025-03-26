# chase ai script
extends CharacterBody2D

@export var navigation_agent: NavigationAgent2D # only access when node is ready in scene tree

@export_category("")
@export var speed: float = 50.0

var _player: CharacterBody2D
var _chase_point: Vector2

func _ready() -> void:
	if get_tree().has_group("player"):
		_player = get_tree().get_first_node_in_group("player")
	
	navigation_agent.debug_enabled = false

func _process(_delta: float) -> void:
	$Sprite2D.play("move_down")

func _physics_process(_delta: float) -> void:
	
	# Calculate path to player
	_chase_point = _player.global_position
	navigation_agent.target_position = _chase_point
	
	var chase_direction := global_position.direction_to(navigation_agent.get_next_path_position()) 
	var desired_velocity = chase_direction * speed
	velocity = desired_velocity
	
	move_and_slide()
