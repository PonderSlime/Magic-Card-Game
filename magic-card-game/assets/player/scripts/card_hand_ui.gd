extends Control

@export var card_scene: PackedScene = preload("res://assets/cards/cards/card_blank.tscn")
@export var card_count = 5.
@export var base_radius: float = 300.
@export var min_angle_range: float = 5.
@export var max_angle_range: float = 50
@export var max_card_count: int = 10.
@export var tightness: float = 1.
@export var hand_offset: float = 75.

@onready var hand_container = self     # The node holding all the cards
var center
var cards: Array = []
var radius
func _ready() -> void:
	get_viewport().set_physics_object_picking_sort(true)
	get_viewport().set_physics_object_picking_first_only(true)
	center = Vector2(size.x / 2, size.y)
	print(size.x, ",", size.y)
	radius = base_radius + (hand_offset * 2)
	add_card(card_scene)
	add_card(card_scene)
	add_card(card_scene)
	add_card(card_scene)
	add_card(card_scene)

func add_card(card_scene: PackedScene):
	var card_instance = card_scene.instantiate()
	cards.append(card_instance)
	hand_container.add_child(card_instance)
	update_hand_layout()
	
func remove_card(card: PackedScene):
	if card in cards:
		cards.erase(card)
		update_hand_layout()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		add_card(card_scene)

func update_hand_layout():
	var range_increase = (cards.size() - 1) / (max_card_count)
	var radius = base_radius + (hand_offset * 2)
	var angle_range = min_angle_range + (range_increase * 100)
	
	angle_range = clamp(angle_range, min_angle_range, max_angle_range)
	
	var angle_step = deg_to_rad(angle_range) / (cards.size() - 1)
	var adjusted_radius = radius * tightness
	var start_angle = deg_to_rad(-angle_range / 2)
	
	for i in range(cards.size()):
		var card = cards[i]
		
		var angle = start_angle + i * angle_step
		var target_position = center + Vector2((adjusted_radius * sin(angle)) * 5, ((- adjusted_radius * cos(angle)) + hand_offset))
		var target_rotation_degrees = rad_to_deg(angle)
		
		card.position = center
		card.rotation_degrees = 0
		
		var tween = create_tween()
		tween.parallel().tween_property(card, "position", target_position, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.parallel().tween_property(card, "rotation_degrees", target_rotation_degrees, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		
		card.z_index = i
		card.set_card_data("Card" + str(i + 1), )
		print("Card Position: ", target_position)
		await get_tree().create_timer(0.2).timeout
