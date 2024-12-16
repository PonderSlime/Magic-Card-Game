extends Node

var initial_health: float = 21
var player_health: float = initial_health
var initial_mana: float = 10
var player_mana: float = initial_mana - 2
signal player_turn

func on_player_turn():
	player_turn.emit()
	
func _process(delta: float) -> void:
	if player_mana < initial_mana:
		player_mana += 0.01
	else:
		return
	print(player_mana)
