extends Node2D

@onready var _path: Path2D = $Path2D
@onready var _line: Line2D = $Line2D
#region particle animation
@onready var _particles: GPUParticles2D = $GPUParticles2D
@onready var _animation_player: AnimationPlayer = $AnimationPlayer
#endregion

func fire(target_global_position: Vector2) -> void:
	var distance_to_target := global_position.distance_to(target_global_position)
	_path.curve.add_point(
		Vector2.ZERO, # why add two vector(0,0)
		Vector2.ZERO,
		global_transform.x * distance_to_target * 0.5
	)
	
	var curve_end_position := target_global_position + generate_random_vector(50.0)
	_path.curve.add_point(
		to_local(curve_end_position), # what are the points being added
		generate_random_vector(distance_to_target),
		Vector2.ZERO
	)
	
	_line.points = _path.curve.get_baked_points() # how is the count being reset? local to scnene
	_particles.global_position = curve_end_position
	_animation_player.play("arc_fire")
	
static func generate_random_vector(maximum_length: float) -> Vector2:
	var random_direction := Vector2.from_angle(randf_range(0, 2 * PI)) # this is cool
	var random_length := randf_range(0, maximum_length)
	return random_direction * random_length
	
