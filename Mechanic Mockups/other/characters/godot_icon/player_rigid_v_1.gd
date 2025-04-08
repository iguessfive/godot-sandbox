extends RigidBody2D

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# store the direction by input
	# subtract the positive x direction by the negative direction input strength
	var direction = (
		Input.get_action_strength(&"move_right") - Input.get_action_strength(&"move_left")
	)
	
	linear_velocity += direction * 100.0 * Vector2.RIGHT
	

		
	if Input.is_action_pressed(&"move_up") and is_on_floor(state):
		apply_central_impulse(Vector2.UP * state.step * 100000.0)

func _ready() -> void:
	max_contacts_reported = 4
func is_on_floor(state: PhysicsDirectBodyState2D) -> bool:
	for contact_index in state.get_contact_count():
		var contact_normal := state.get_contact_local_normal(contact_index)
		if contact_normal.dot(Vector2.UP) > 0.5:
			return true
	return false
