extends Control
@onready var health_bar = $HealthBar
@onready var status_bar = $StatusBar

func _process(delta: float) -> void:
	var val = (Opponent.opponent_health / Opponent.opponent_start_health) * 100
	var tween = create_tween()
	tween.tween_property(status_bar, "value", val - 7, 0.75).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	health_bar.value = val
