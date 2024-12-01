extends Control

@export var play_zone: Area2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.card_played.connect(_on_card_played)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_card_played(card_data: CardData):
	if card_data.data_name == "default_card":
		print("womp womp! you played ", card_data.data_name, "!")
	
	elif card_data.data_name == "fire_card":
		print("Yay! Fire! You played ", card_data.data_name, "!")
		
	else:
		print("bro messed up big time when coding!")
