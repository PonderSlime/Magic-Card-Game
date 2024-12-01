extends Area2D

@export var snap_group: Array = []
@export var hand_container: Control
@export var group_name: String = "hand"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_collisions()

func check_collisions() -> void:
	if Input.is_action_just_released("click"):
		var overlapping_areas = get_overlapping_areas()
		for area in overlapping_areas:
			if area.is_in_group("cards"):
				if !area.is_in_group(group_name):
					snap_card(area)
				
func snap_card(card: Node) -> void:
	snap_group.append(card)
	if hand_container:
		hand_container.add_card(card)
		card.add_to_group(group_name)
