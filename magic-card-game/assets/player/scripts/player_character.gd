extends Node2D

@onready var state_machine = $AnimationTree.get("parameters/playback")

func _ready() -> void:
	Player.player_turn.connect(player_turn)
	gather_spell()

func _process(delta: float) -> void:
	pass
	
func flick_spell():
	state_machine.travel("player_flick_spell")
	
func gather_spell():
	state_machine.travel("player_gather_spell")
	print("gather!")
func player_turn():
	gather_spell()
	
func on_card_played():
	flick_spell()
	print("timer started")
	await get_tree().create_timer(.6).timeout
	print("timer ended")
	gather_spell()
