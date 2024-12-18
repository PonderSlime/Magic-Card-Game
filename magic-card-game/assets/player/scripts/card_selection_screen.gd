extends Control

@onready var card_selection_grid = $CardSelection/ScrollContainer/GridContainer
@onready var selected_cards_container = $GridContainer

func _ready():
	populate_selection_grid()
			
	print("hand: ", Globals.selected_hand)
	update_selected_cards_display()

func populate_selection_grid():
	for card_data in Globals.all_cards:
		var card_preview = TextureButton.new()
		card_preview.texture_normal = load("res://assets/cards/textures/sprites/" + card_data["texture_name"] + ".png")
		card_preview.stretch_mode = TextureButton.STRETCH_TILE
		card_preview.scale = Vector2(50,50)
		
		card_preview.set_meta("card_data", card_data)
		card_preview.pressed.connect(_on_card_button_pressed.bind(card_data))
		card_selection_grid.add_child(card_preview)
		
func _on_card_button_pressed(card_data):
	if card_data in Globals.selected_hand:
		Globals.selected_hand.erase(card_data)
		print(card_data["name"], " removed from selection.")
	else:
		if Globals.selected_hand.size() < 5:
			Globals.selected_hand.append(card_data)
			print(card_data["name"], "added to selection.")
		else:
			print("Hand is full! Cannot add more cards.")
	update_selected_cards_display()
	
func update_selected_cards_display():
	for child in selected_cards_container.get_children():
		child.queue_free()
	for card_data in Globals.selected_hand:
		var card_preview = TextureButton.new()
		card_preview.texture_normal = load("res://assets/cards/textures/sprites/" + card_data["texture_name"] + ".png")
		card_preview.stretch_mode = TextureButton.STRETCH_TILE
		card_preview.scale = Vector2(50,50)
		
		card_preview.set_meta("card_data", card_data)
		card_preview.pressed.connect(_on_remove_card_pressed.bind(card_data, card_preview))
		selected_cards_container.add_child(card_preview)

func _on_remove_card_pressed(card_data, card_preview):
	Globals.selected_hand.erase(card_data)
	selected_cards_container.remove_child(card_preview)
	print(card_data["name"], "removed from selection.")
	update_selected_cards_display()

func confirm_selection():
	if Globals.selected_hand.size() == 0:
		print("No cards are selected!")
		return
	for card_data in Globals.selected_hand:
		var path = card_data["scene_path"]
		var card = load(path)
		var card_instance = card.instantiate()
	print("Game hand populated with selected cards.")
	save_game()
	get_tree().change_scene_to_file("res://assets/menu/main_menu.tscn")
func save_game():
	var saveFile = FileAccess.open("user://selected_cards.save", FileAccess.WRITE)
	if(FileAccess.get_open_error() != OK):
		return false
	
	for card_data in Globals.selected_hand:
		var scene_path = card_data["scene_path"]
		var name = card_data["name"]
		var data_name = card_data["data_name"]
		var texture_name = card_data["texture_name"]
		var description = card_data["description"]
		var save_dict = {"scene_path" : scene_path, "name": name, "data_name": data_name, "texture_name": texture_name, "description": description}
		
		var json_string = JSON.stringify(save_dict)
		saveFile.store_line(json_string)
