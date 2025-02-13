extends TextureProgressBar
@export var is_ammount_indicator: bool


func _process(delta: float) -> void:
	var val = int((Player.player_health / Player.initial_health) * 100)
	if is_ammount_indicator:
		var tween = create_tween()
		tween.tween_property(self, "value", val - 5, 0.75).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	else:
		value = val
