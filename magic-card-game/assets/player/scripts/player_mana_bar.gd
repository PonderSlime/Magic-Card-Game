extends Control
@onready var mana_bar = $HealthBar
@onready var status_bar = $StatusBar

func _process(delta: float) -> void:
	var val = (Player.player_mana / Player.initial_mana) * 100
	var tween = create_tween()
	tween.tween_property(status_bar, "value", val, 0.75).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	mana_bar.value = val
	#print(val)
