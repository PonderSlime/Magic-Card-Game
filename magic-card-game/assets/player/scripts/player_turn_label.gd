extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.ended_enemy_turn.connect(show_label)
	modulate = Color(1, 1, 1, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_label():
	modulate = Color(1, 1, 1, 0)
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
