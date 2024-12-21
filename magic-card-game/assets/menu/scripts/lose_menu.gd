extends Control

func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	if Player.player_health <= 0:
		visible = true

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	visible = false
	Player.player_health = Player.initial_health
	Player.player_mana = Player.initial_mana - 2
	Opponent.opponent_health = Opponent.opponent_start_health
	get_tree().change_scene_to_file("res://assets/main_scene.tscn")

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://assets/menu/main_menu.tscn")
