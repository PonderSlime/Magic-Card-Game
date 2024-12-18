extends Node

var opponent_start_health: float = 20
@onready var opponent_health: float = opponent_start_health
var enemy_hand = []

func _ready() -> void:
	enemy_hand = Globals.selected_hand

func opponent_turn():
	var card_data = get_random_card()
	SignalBus.card_played.emit(card_data, "opponent")
	Player.on_player_turn()
func get_random_card() -> CardData:
	if enemy_hand.size() == 0:
		print("No cards available in the selected hand!")
		return null
	var random_index = randi() % enemy_hand.size()
	var card_data = enemy_hand[random_index]
	return CardData.new(card_data["name"], card_data["data_name"],card_data["scene_path"], 2, card_data["description"])
