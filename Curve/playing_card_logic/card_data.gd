# The script is a `resource` called `CardData`
# The data stored are all properites of a standard playing card

class_name CardData extends Resource

# Define the following properties for a `CardData` object using @export

# `@export` allow editing the data in a variable in the editor

# Define a variable to store card rank of type `int`
# Use 1 for Ace, 11 for jack, Queen is 12 and King is 13
# Use `@export_range` to set the rank between 1 to 13 and adjust it's value by a value of 1

@export_range(1, 13, 1) var rank

# Define a variable to store the suit as `string`
# Use `@export_enum` to give pre-filled options

@export_enum("club", "spade", "heart", "diamond") var suit: String

# The following is the front and back texture of the playing card
@export var front_texture: Texture
@export var back_texture: Texture
