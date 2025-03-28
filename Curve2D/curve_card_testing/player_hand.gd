extends Marker2D

const CARD = preload("res://card.tscn")
const CURVE_EXAMPLE = preload("res://curve_example.tres")
const LINE_EXAMPLE = preload("res://line_example.tres")
const ROTATION_CURVE = preload("res://rotation_curve.tres")

const SIZE = Vector2(100, 100)

@export var card_radius: float = 200.0
@export_range(0, 1, 0.01) var card_hand_position: float = 0
@export_range(-45, 45, 1, "radians_as_degrees") var card_rotation: float = -45

var card_hand_list: Array = []
var number = 0
var _selected_card: Node2D
var _card_handler := _create_card_handler()

@onready var npc_text_label: RichTextLabel = %NPCTextLabel
@onready var play_button: Button = %PlayButton
@onready var draw_button: Button = %DrawButton
@onready var discard_button: Button = %DiscardButton
@onready var reload_button: Button = %ReloadButton

func _ready() -> void:
	for node in get_children():
		node.queue_free()
	draw_button.pressed.connect(_draw_card)
	discard_button.pressed.connect(_dicard_card)
	reload_button.pressed.connect(get_tree().reload_current_scene)
	add_child(_card_handler)
	_card_handler.name = "CardHandler"
	_card_handler.global_position = global_position

func _draw_card():
	_create_card()
	_update_card_hand()
	
func _dicard_card():
	if card_hand_list != []:
		var remove_front_card = card_hand_list.pop_front()
		remove_front_card.queue_free()
		_update_card_hand()
		
func _create_card():
	var card = CARD.instantiate()
	card_hand_list.append(card)
	_card_handler.add_child(card)
	card.label.text = "Gobot " + str(number)
	number += 1

func _create_card_handler() -> CardHandler:
	var card_handler = CardHandler.new()
	return card_handler

func _update_card_hand():
	var total_cards:float = card_hand_list.size() + 1
	var multiplier: float = 0.0
	for card: Node2D in card_hand_list:
		multiplier += 1.0
		var card_spread := 1.0 / total_cards
		var offset = card_spread * multiplier
		var card_x_position := LINE_EXAMPLE.sample(offset)
		var card_y_position := CURVE_EXAMPLE.sample(offset)
		card.rotation = ROTATION_CURVE.sample(offset)
		card.position = Vector2(card_x_position, card_y_position) * -card_radius
	
func _reset_card_parameters():
	card_hand_position = 0
