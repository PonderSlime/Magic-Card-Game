extends Control

@onready var bg_music_player_1: AudioStreamPlayer = $BackGroundMusicPlayer1
func _ready() -> void:
	bg_music_player_1.play()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/main_scene.tscn")
	print("opening game!")


func _on_card_selection_button_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/player/card_selection.tscn")
	print("opening card selection!")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
