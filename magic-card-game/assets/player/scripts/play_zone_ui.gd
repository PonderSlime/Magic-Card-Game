extends Control

@export var snap_zone: Area2D
@onready var snap_zone_shape = snap_zone.get_node("CollisionShape2D").shape
@export var base_snap_zone_width: float = 2000
@export var base_snap_zone_height: float = 400
@export var snap_zone_padding: float = 20

signal card_played(card_name: String)

var cards: Array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	var play_area_width = max(base_snap_zone_width, cards.size() * 100 + snap_zone_padding)
	var play_area_height = base_snap_zone_height
	
	if snap_zone_shape is RectangleShape2D:
		snap_zone_shape.extents = Vector2(play_area_width / 2, play_area_height / 2)


func add_card(card: Node2D) -> void:
	cards.append(card)
	var tween = create_tween()
	tween.tween_property(card, "scale", Vector2.ZERO, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(card, "modulate", Color(0,0,0,0), 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(0.3).timeout
	print(card.name, " goes poof")
	emit_signal("card_played", card.name)
	card.queue_free()