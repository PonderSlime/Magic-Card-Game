extends Node2D

@export var card_name : String = ""
@export var card_texture: Texture2D
@export var offset: float = 25
@export var scale_diff: float = 1.1
@export var card_overlay: PackedScene = preload("res://assets/cards/globals/card_overlay.tscn")
@onready var card = $Card
@onready var card_label = $Card/Label

var hover_scale = 0.
var base_scale = 0.
var card_position = 0.
@onready var area2d = self
func _ready() -> void:
	if card:
		print("Card node found!")
		hover_scale = card.scale * scale_diff
		base_scale = card.scale
	else:
		print("Card node missing!")

func set_card_data(name: String):
	card_name = name
	card_texture = card.texture
	if card_label:
		card_label.text = name
	else:
		print("Label node not found!")

func _on_mouse_entered() -> void:
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

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		show_overlay()
		
		
func show_overlay():
	print("overlay!")
	var overlay_instance = card_overlay.instantiate()
	get_tree().root.add_child(overlay_instance)
	print(global_position)
	overlay_instance.set_card_data(card_name, card_texture, global_position, card.scale.x, rotation)
