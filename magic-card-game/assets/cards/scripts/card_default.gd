extends Node2D

@export var card_name : String = ""
@export var offset: float = 25
@export var scale_diff: float = 1.1
@onready var card = $Card
@onready var card_label = $Card/Label
var hover_scale = 0.
var base_scale = 0.

func _ready() -> void:
	if card:
		print("Card node found!")
		hover_scale = card.scale * scale_diff
		base_scale = card.scale
	else:
		print("Card node missing!")

func set_card_data(name: String):
	card_name = name
	if card_label:
		card_label.text = name
	else:
		print("Label node not found!")

func _on_mouse_entered() -> void:
	print("hover!")
	
	var target_position = Vector2(0, -offset)
	var target_scale = hover_scale
	card.position = Vector2(0,0)
	card.scale = base_scale
	
	var tween = create_tween()
	tween.parallel().tween_property(card, "position", target_position, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(card, "scale", target_scale, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _on_mouse_exited() -> void:
	
	var target_position = Vector2(0,0)
	var target_scale = base_scale
	card.position = Vector2(0, -offset)
	card.scale = hover_scale
	
	var tween = create_tween()
	tween.parallel().tween_property(card, "position", target_position, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(card, "scale", target_scale, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
