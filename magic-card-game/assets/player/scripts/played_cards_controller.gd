extends Control

@export var play_zone: Area2D
@export var player_character: Node2D
@export var enemy_health_bar: Control
@export var sound_player: Control

func _ready() -> void:
	SignalBus.card_played.connect(_on_card_played)

func _on_card_played(card_data: CardData, who: String):
	if card_data.data_name == "lightning_card":
		if who == "player":
			if Player.player_mana >= 9:
				Opponent.opponent_health -= 8
				Player.player_mana -= 9
				sound_player.card_played()
				print("Your opponent's health is now at: ", Opponent.opponent_health)
			else:
				print("Not enough Mana!")
				sound_player.card_failed()
			player_character.on_card_played()
		else:
			print("Opponent played ", card_data.data_name, "!")
			Player.player_health -= 8
			print("Your health is now at: ", Player.player_health)
	
	elif card_data.data_name == "fire_card":
		if who == "player":
			if Player.player_mana >= 1:
				Opponent.opponent_health -= 2
				Player.player_mana -= 1
				sound_player.card_played()
				print("Your opponent's health is now at: ", Opponent.opponent_health)
			else:
				print("Not enough Mana!")
				sound_player.card_failed()
			player_character.on_card_played()
		else:
			print("Opponent played ", card_data.data_name, "!")
			Player.player_health -= 2
			print("Your health is now at: ", Player.player_health)
			
	elif card_data.data_name == "heal_card":
		if who == "player":
			if Player.player_mana >= 2:
				Player.player_health += 2
				Player.player_mana -= 2
				sound_player.card_played()
				print("Your health is now at: ", Player.player_health)
			else:
				print("Not enough Mana!")
				sound_player.card_failed()
			player_character.on_card_played()
		else:
			print("Opponent played ", card_data.data_name, "!")
			Opponent.opponent_health += 2
			print("Your Opponent's health is now at: ", Opponent.opponent_health)
			
	elif card_data.data_name == "big_heal_card":
		if who == "player":
			if Player.player_mana >= 5:
				Player.player_health += 6
				Player.player_mana -= 5
				sound_player.card_played()
				print("Your health is now at: ", Player.player_health)
			else:
				print("Not enough Mana!")
				sound_player.card_failed()
			player_character.on_card_played()
		else:
			print("Opponent played ", card_data.data_name, "!")
			Opponent.opponent_health += 6
			print("Your Opponent's health is now at: ", Opponent.opponent_health)
	
	else:
		print("bro messed up big time when coding!")
		print("card name: ", card_data.data_name)
		
	if Opponent.opponent_health <= 0:
		print("Player beat the opponent!")
		
	if Player.player_health <= 0:
		print("Opponent beat the player!")
