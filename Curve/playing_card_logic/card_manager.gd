# The script is a resource called `CardManager`
# The primary goal is store a standard deck of playing cards

class_name CardManager extends Resource

# Array of `CardData` or a standard deck of 52 playing cards

@export var standard_deck: Array[CardData]

# For easier access, preloaded the back texture for all the cards here

@export var card_back_texture: Texture = preload("res://assets/card_extras/card_back.png")
