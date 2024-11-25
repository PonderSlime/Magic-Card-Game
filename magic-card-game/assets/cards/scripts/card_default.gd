extends Node2D

@export var card_name : String = ""

func set_card_data(name: String):
	card_name = name
	$Label.text = name if has_node("Label") else ""
