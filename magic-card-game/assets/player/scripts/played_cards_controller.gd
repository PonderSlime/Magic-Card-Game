extends Control

@export var play_zone: Area2D

func _ready() -> void:
	SignalBus.card_played.connect(_on_card_played)

func _on_card_played(card_data: CardData, who: String):
	if card_data.data_name == "default_card":
		if who == "player":
			print("womp womp! you played ", card_data.data_name, "!")
			Opponent.opponent_health - 1
		else:
			print("Opponent played ", card_data.data_name, "!")
			Player.player_health - 1
	
	elif card_data.data_name == "fire_card":
		if who == "player":
			print("Yay! Fire! You played ", card_data.data_name, "!")
			Opponent.opponent_health - 2
		else:
			print("Opponent played ", card_data.data_name, "!")
			Player.player_health - 2
		
	else:
		print("bro messed up big time when coding!")
