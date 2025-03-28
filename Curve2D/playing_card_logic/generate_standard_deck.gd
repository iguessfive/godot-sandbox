# This script will generate the `CardManager` and a deck of 52 playing cards

@tool
extends EditorScript

func _run() -> void:
	generate_standard_deck()

func generate_standard_deck():
	var card_manager := CardManager.new()
	
	var suit_types: Array[String] = ["club", "spade", "heart", "diamond"]
	
	for suit in suit_types: # for each suit create ranks 1 to 13
		var new_suit_ranks_mapping = generate_ranks_for_suit(suit)
		
		for each_rank in new_suit_ranks_mapping: # add each card to standard deck array in card manager
			card_manager.standard_deck.append(each_rank)
	
	for card in card_manager.standard_deck: # for each card, add the preloaded back texture
		card.back_texture = card_manager.card_back_texture
	
	var filename := "card_manager.tres" # enter filename
	const FOLDER_PATH = "res://playing_card_logic/" # location of file
	var path := FOLDER_PATH + filename
	# save the resource to disk
	ResourceSaver.save(card_manager, path) # open `card_manager.tres` and view cards in inspector
	
func generate_ranks_for_suit(suit: String) -> Array[CardData]: # pass the suit in
	var suit_rank_mapping: Array[CardData] # contains all ranks of a suit
	
	const RANK_COUNT = 13
	
	var texture_name: String # file name of card sprite
	
	for rank in range(RANK_COUNT):
		# unique file name in `card_images`
		texture_name = suit + "_" + str(rank+1) # updates the file name for each rank and uses suit passed in
		var new_card_data = generate_playing_card_data(rank+1, suit, texture_name)
		suit_rank_mapping.append(new_card_data) # an array for all ranks for passed in suit
		
	return suit_rank_mapping
	
	# pass in rank, suit and texture file name in card assets folder
func generate_playing_card_data(rank: int, suit: String, texture_name: String) -> CardData:
	# location of textures
	const FOLDER_PATH = "res://assets/card_images/" # folder containing card assets
	var texture: Texture2D = load(FOLDER_PATH+"card_"+texture_name+".png") # full path of card image in file system
	
	# creates the card data
	var playing_card := CardData.new()
	playing_card.rank = rank
	playing_card.suit = suit
	playing_card.front_texture = texture
	
	return playing_card
