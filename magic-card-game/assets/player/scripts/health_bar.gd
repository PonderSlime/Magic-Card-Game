extends TextureProgressBar

func _process(delta: float) -> void:
	var val = int((Player.player_health / Player.initial_health) * 100)
	var tween = create_tween()
	tween.tween_property(self, "value", val, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
