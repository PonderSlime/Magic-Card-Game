extends Area2D

@export var card_container: Control
@export var texture: TextureRect
@export var parent: Control

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("click"):
			if Globals.card_count < Globals.max_card_count:
				card_container.add_new_card(parent.position)
				print("global pos: ", parent.global_position)
			else:
				wiggle_deck()

func wiggle_deck():
	var tween = create_tween()
	var initial_position = Vector2.ZERO
	var wiggle_ammount = 10
	var wiggle_time = 0.05
	
	tween.tween_property(texture, "position", initial_position + Vector2(wiggle_ammount, 0), wiggle_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(texture, "position", initial_position - Vector2(wiggle_ammount, 0), wiggle_time).set_delay(wiggle_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(texture, "position", initial_position, wiggle_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
