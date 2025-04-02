extends Control

@onready var toggle_sprite_placement_button: Button = %ToggleSpritePlacementButton
@onready var tile_map_layer: TileMapLayer = %TileMapLayer

var is_sprite_placing: bool = false

var tile_data: Dictionary[Vector2i, Sprite2D] = {}

func _ready() -> void:
	toggle_sprite_placement_button.pressed.connect(func():
		is_sprite_placing = not is_sprite_placing
	)

func _unhandled_input(event: InputEvent) -> void:
	var is_mouse_left_button_pressed: bool = (
		event is InputEventMouseButton
		and event.pressed == true
		and event.button_index == MOUSE_BUTTON_LEFT
	)
	if is_mouse_left_button_pressed and is_sprite_placing:
		place_sprite()
		
@warning_ignore("unused_parameter")
func place_sprite() -> void:
	var icon: Texture = preload("res://icon.svg")
	var sprite_2d = Sprite2D.new()
	sprite_2d.texture = icon
	sprite_2d.scale *= 0.25
	
	var tile_coordinates = tile_map_layer.local_to_map(tile_map_layer.get_local_mouse_position())
	if tile_map_layer.get_cell_tile_data(tile_coordinates) != null:
		if tile_data.has(tile_coordinates):
			return
			
		get_tree().current_scene.add_child(sprite_2d)
		sprite_2d.global_position = tile_map_layer.map_to_local(tile_coordinates)
		tile_data[tile_coordinates] = sprite_2d
		
		
	
	
	
	
