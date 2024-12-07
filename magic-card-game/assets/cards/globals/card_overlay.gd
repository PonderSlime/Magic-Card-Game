extends CanvasLayer

@onready var texture_rect = $Control/CenterContainer/ControlCard/Card
@onready var label = $Control/Label
var cardpos = Vector2(0,0)
var screen_center
var cardrot
var cardsca

func set_card_data(name: String, texture: Texture2D, card_position: Vector2, card_scale: float, card_rotation: float):
	if texture_rect:
		texture_rect.texture = texture
	if label:
		label.text = name
	if card_position:
		cardpos = card_position
		var tween = create_tween()
		tween.tween_property(texture_rect, "global_position", cardpos, 0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	if card_rotation:
		cardrot = card_rotation
		texture_rect.rotation = cardrot
		
	if card_scale:
		cardsca = card_scale
		texture_rect.scale.x = cardsca
		texture_rect.scale.y = cardsca
	show_with_animation()
		
func _on_control_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		hide_with_animation()
		
func show_with_animation():
	var tween = create_tween()
	tween.parallel().tween_property(texture_rect, "scale", Vector2(texture_rect.scale.x *2, texture_rect.scale.y *2,), 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(texture_rect, "position", Vector2(0,0), 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(texture_rect, "rotation", 0, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func hide_with_animation():
	texture_rect.rotation = 0
	var tween = create_tween()
	tween.parallel().tween_property(texture_rect, "scale", Vector2(cardsca, cardsca), 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(texture_rect, "global_position", cardpos, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	if texture_rect.rotation != 0:
		tween.parallel().tween_property(texture_rect, "rotation", cardrot, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(0.4).timeout
	queue_free()
