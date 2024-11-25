extends Control

@export var card_scene: PackedScene = preload("res://assets/cards/cards/card_blank.tscn")
@export var card_count = 5
@export var radius: float = 300.
@export var min_angle_range: float = 45.
@export var max_angle_range: float = 120.
@export var max_card_count: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var center = Vector2(size.x / 2, size.y)
	var range_increase = (card_count - 1) / (max_card_count - 1)
	var angle_range = lerp(min_angle_range, max_angle_range, range_increase)
	
	angle_range = clamp(angle_range, min_angle_range, max_angle_range)
	
	var angle_step = deg_to_rad(angle_range) / (card_count - 1)
	var start_angle = deg_to_rad(-angle_range / 2)
	
	var container = Node2D.new()
	container.position = center
	add_child(container)
	
	container.rotation = 0.	
	container.rotation = deg_to_rad(-(angle_range /3) / 2)
	
	for i in range(card_count):
		var card_instance = card_scene.instantiate()
		container.add_child(card_instance)
		
		var angle = start_angle + i * angle_step
		var target_position = center + Vector2(radius * sin(angle), - radius * cos(angle))
		var target_rotation_degrees = rad_to_deg(angle)
		
		card_instance.position = center
		card_instance.rotation_degrees = 0
		
		var tween = create_tween()
		tween.parallel().tween_property(card_instance, "position", target_position, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.parallel().tween_property(card_instance, "rotation_degrees", target_rotation_degrees, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

		
		card_instance.z_index = i
		card_instance.set_card_data("Card" + str(i + 1))
		print("Card Position: ", target_position)
		await get_tree().create_timer(0.2).timeout

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
