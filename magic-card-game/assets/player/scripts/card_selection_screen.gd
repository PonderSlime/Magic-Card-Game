extends Control

@export var all_cards: Array = [
	{"scene_path": "res://assets/cards/cards/card_blank.tscn", "name": "Default Card", "texture_name": "blank-card"},
	{"scene_path": "res://assets/cards/cards/card_fire.tscn", "name": "Fire Card", "texture_name": "fire-card"},
]

@onready var card_selection_grid = $ScrollContainer/GridContainer
var selected_hand: Array = []

func _ready():
	populate_selection_grid()
	var saveFile = FileAccess.open("user://selected_cards.save", FileAccess.READ)
	if(FileAccess.get_open_error() != OK):
		return false
	while saveFile.get_position() < saveFile.get_length():
		var json_string = saveFile.get_line()
		
		var json = JSON.new()
		
		var parse_result = json.parse(json_string)
		
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
			
		var node_data = json.get_data()
		#print(node_data)
		#for item in node_data:
		selected_hand.append(node_data)
			
	print(selected_hand)
		#selected_hand = node_data

func populate_selection_grid():
	#card_selection_grid.clear()
	
	for card_data in all_cards:
		var card_preview = TextureButton.new()
		card_preview.texture_normal = load("res://assets/cards/textures/sprites/" + card_data["texture_name"] + ".png")
		card_preview.stretch_mode = TextureButton.STRETCH_TILE
		card_preview.scale = Vector2(50,50)
		
		card_preview.set_meta("card_data", card_data)
		card_preview.pressed.connect(_on_card_button_pressed.bind(card_data))
		card_selection_grid.add_child(card_preview)
		
		
func _on_card_button_pressed(card_data):
	if card_data in selected_hand:
		selected_hand.erase(card_data)
		print(card_data["name"], " removed from selection.")
		
	else:
		if selected_hand.size() < 5:
			selected_hand.append(card_data)
			print(card_data["name"], "added to selection.")
		else:
			print("Hand is full! Cannot add more cards.")
			
func confirm_selection():
	if selected_hand.size() == 0:
		print("No cards are selected!")
		return
	for card_data in selected_hand:
		var path = card_data["scene_path"]
		var card = load(path)
		var card_instance = card.instantiate()
		#add_card_to_hand(card_instance)
	print("Game hand populated with selected cards.")
	save_game()
	
func save_game():
	var saveFile = FileAccess.open("user://selected_cards.save", FileAccess.WRITE)
	if(FileAccess.get_open_error() != OK):
		return false
	
	for card_data in selected_hand:
		var scene_path = card_data["scene_path"]
		var name = card_data["name"]
		var texture_name = card_data["texture_name"]
		var save_dict = {"scene_path" : scene_path, "name": name, "texture_name": texture_name}
		
		var json_string = JSON.stringify(save_dict)
		saveFile.store_line(json_string)
