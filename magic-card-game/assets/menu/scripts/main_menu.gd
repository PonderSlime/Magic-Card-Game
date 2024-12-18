extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/main_scene.tscn")
	print("opening game!")


func _on_card_selection_button_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/player/card_selection.tscn")
	print("opening card selection!")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
