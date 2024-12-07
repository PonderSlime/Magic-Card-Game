extends Node

var initial_health: float = 21
var player_health: float = initial_health

signal player_turn

func on_player_turn():
	player_turn.emit()
