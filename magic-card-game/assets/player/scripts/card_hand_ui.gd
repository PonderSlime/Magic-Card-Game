extends Control

@export var selected_hand: Array = []
var start_card_count = Globals.start_card_count
@export var base_radius: float = 300.
@export var min_angle_range: float = 5.
@export var max_angle_range: float = 50
var max_card_count = Globals.max_card_count
@export var tightness: float = 1.
@export var hand_offset: float = 75.

@export var snap_zone: Area2D
@onready var snap_zone_shape = snap_zone.get_node("CollisionShape2D").shape
@export var base_snap_zone_width: float = 900
@export var base_snap_zone_height: float = 700
@export var snap_zone_padding: float = 20

@onready var hand_container = self     # The node holding all the cards
var center
var cards: Array = []
var radius
func _ready() -> void:
	get_viewport().set_physics_object_picking_sort(true)
	get_viewport().set_physics_object_picking_first_only(true)
	
	load_selected_cards()
	
	radius = base_radius + (hand_offset * 2)
	for i in start_card_count:
		add_new_card(Vector2.ZERO)
func _process(delta: float) -> void:
	update_snap_zone()
	
func load_selected_cards():
	var saveFile = FileAccess.open("user://selected_cards.save", FileAccess.READ)
	if(FileAccess.get_open_error() != OK):
		return false
	while saveFile.get_position() < saveFile.get_length():
		var json_string = saveFile.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
			
		var node_data = json.get_data()
		selected_hand.append(node_data)
			
	print(selected_hand)
	
func get_random_card_scene() -> PackedScene:
	
	var random_card = selected_hand[randi() % selected_hand.size()]
	
	return load(random_card["scene_path"])
	
func add_new_card(position: Vector2):
	var card_scene = get_random_card_scene()
	var card_instance = card_scene.instantiate()
	card_instance.position = position
	card_instance.rotation_degrees = 0
	card_instance.scale = Vector2.ZERO
	card_instance.modulate = Color(0,0,0,0)
	add_card(card_instance)
	card_instance.add_to_group("hand")
	
func add_card(card: Node2D):
	hand_container.add_child(card)
	card.hand_container = self
	var tween = create_tween()
	tween.parallel().tween_property(card, "scale", Vector2(1, 1), 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(card, "modulate", Color(1, 1, 1, 1), 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	cards.append(card)
	await get_tree().create_timer(0.1).timeout
	update_hand_layout()
	update_snap_zone()
	Globals.card_count += 1
	
func remove_card(card: Node2D):
	if card in cards:
		cards.erase(card)
		update_hand_layout()
		update_snap_zone()
		Globals.card_count -= 1

func update_hand_layout():
	var range_increase = float(cards.size()) / float(max_card_count)
	var radius = base_radius + (hand_offset * 2)
	var angle_range = min_angle_range + (range_increase * (max_angle_range - min_angle_range))
	
	angle_range = clamp(angle_range, min_angle_range, max_angle_range)
	
	var angle_step = deg_to_rad(angle_range) / (cards.size())
	var adjusted_radius = radius * tightness
	var start_angle = deg_to_rad(-angle_range / 2)
	
	for i in range(cards.size()):
		var card = cards[i]
		
		var angle = start_angle + i * angle_step
		var target_position = Vector2((adjusted_radius * sin(angle)) * 5, ((- adjusted_radius * cos(angle)) + hand_offset))
		var target_rotation_degrees = rad_to_deg(angle)
		
		var tween = create_tween()
		tween.parallel().tween_property(card, "position", target_position, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.parallel().tween_property(card, "rotation_degrees", target_rotation_degrees, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		
		card.z_index = i
		card.set_card_data("Card",) #+ str(i + 1), )
		print("Card Position: ", target_position)

func update_snap_zone():
	if not snap_zone:
		return
	
	var hand_width = max(base_snap_zone_width, cards.size() * 100 + snap_zone_padding)
	var hand_height = base_snap_zone_height
	
	if snap_zone_shape is RectangleShape2D:
		snap_zone_shape.extents = Vector2(hand_width / 2, hand_height / 2)
		
	snap_zone.position = Vector2(get_parent().size.x / 2, 0)
