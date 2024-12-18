extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var pause_game: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_is_paused()
	if get_tree().paused:
		$Menu.visible = true
	else:
		$Menu.visible = false

func _is_paused():
	if Input.is_action_just_pressed("ui_cancel"):
		pause_game = !pause_game
		get_tree().paused = !get_tree().paused
		
func _on_play_button_pressed() -> void:
	get_tree().paused = !get_tree().paused

func _on_forfeit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://assets/menu/main_menu.tscn")
