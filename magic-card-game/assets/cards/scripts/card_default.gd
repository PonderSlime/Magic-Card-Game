extends Node2D

@export var card_name : String = ""
@export var card_texture: Texture2D
@export var offset: float = 25
@export var scale_diff: float = 1.1
@export var card_overlay: PackedScene = preload("res://assets/cards/globals/card_overlay.tscn")
@onready var card = $Card
@onready var card_label = $Content/Label
@export var remove_threshold: float = 500.0
var hand_container: Node = null

var hover_scale = 0.
var base_scale = 0.
var card_position = 0.

var is_dragging = false
var click_timer: Timer
var has_dragged = false
var drag_threshold = 20
var drag_start_position = Vector2.ZERO
var drag_offset = Vector2.ZERO

var selected_hand: Array = []

@onready var area2d = self
func _ready() -> void:
	add_to_group("cards")
	if card:
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
	if not is_dragging:
		var target_position = Vector2(0, -offset)
		var target_scale = hover_scale
		card.position = Vector2(0,0)
		card.scale = base_scale
		
		var tween = create_tween()
		tween.parallel().tween_property(card, "position", target_position, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.parallel().tween_property(card, "scale", target_scale, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
func _on_mouse_exited() -> void:
	if not is_dragging:
		var target_position = Vector2(0,0)
		var target_scale = base_scale
		card.position = Vector2(0, -offset)
		card.scale = hover_scale
		
		var tween = create_tween()
		tween.parallel().tween_property(card, "position", target_position, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.parallel().tween_property(card, "scale", target_scale, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("click"):
			is_dragging = true
			has_dragged = false
			drag_start_position = get_global_mouse_position()
			drag_offset = global_position - drag_start_position
			
		elif Input.is_action_just_released("click"):
			is_dragging = false
			var distance_moved = drag_start_position.distance_to(get_global_mouse_position())
			if distance_moved < drag_threshold:
				show_overlay()
			drag_start_position = Vector2.ZERO
			drag_offset = Vector2.ZERO
	elif event is InputEventMouseMotion and is_dragging:
		var distance_moved = drag_start_position.distance_to(get_global_mouse_position())
		global_position = get_global_mouse_position() + drag_offset
		if distance_moved > drag_threshold:
			hand_container.remove_card(self)
			remove_from_group("hand")
			hand_container.update_hand_layout()
			var tween = create_tween()
			tween.parallel().tween_property(area2d, "rotation", 0, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
			has_dragged = true
	
	if is_dragging:
		var tween = create_tween()
		tween.tween_property(card, "scale", base_scale * 0.9, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	else:
		var tween = create_tween()
		tween.tween_property(card, "scale", base_scale, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
func _process(delta: float) -> void:
	if is_dragging:
		global_position = get_global_mouse_position() + drag_offset
	if is_dragging and Input.is_action_just_released("click"):
		is_dragging = false
		
func show_overlay():
	var overlay_instance = card_overlay.instantiate()
	get_tree().root.add_child(overlay_instance)
	overlay_instance.set_card_data(card_name, card_texture, global_position, card.scale.x, rotation)
