extends Node

var card_count: int = 0
var start_card_count: int = 5
var max_card_count:int = 10
var selected_hand = []

var all_cards: Array = [
	{"scene_path": "res://assets/cards/cards/card_fire.tscn", "name": "Fire Card", "data_name": "fire_card", "texture_name": "fire_card", "description": "basic fire card"},
	{"scene_path": "res://assets/cards/cards/card_lightning.tscn", "name": "Lightning Card", "data_name": "lightning_card", "texture_name": "lightning_card", "description": "lightning card"},
	{"scene_path": "res://assets/cards/cards/card_heal.tscn", "name": "Health Card", "data_name": "heal_card", "texture_name": "heal_card", "description": "basic healing card"},
	{"scene_path": "res://assets/cards/cards/card_big_heal.tscn", "name": "Big Health Card", "data_name": "big_heal_card", "texture_name": "big_heal_card", "description": "boosted healing card"},
]

func _ready() -> void:
	var saveFile = FileAccess.open("user://selected_cards.save", FileAccess.READ)
	if(FileAccess.get_open_error() != OK):
		print("error!")
	while saveFile.get_position() < saveFile.get_length():
		var json_string = saveFile.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
			
		var node_data = json.get_data()
		selected_hand.append(node_data)
		print(selected_hand)
