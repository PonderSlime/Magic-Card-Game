extends TextureButton

@export var hover_scale = Vector2(1.1, 1.1)
@onready var base_scale = self.scale

func _on_mouse_entered() -> void:
	var target_scale = base_scale * hover_scale
	position = Vector2(0,0)
	scale = base_scale
	
	var tween = create_tween()

	tween.parallel().tween_property(self, "scale", target_scale, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
func _on_mouse_exited() -> void:
	var target_position = Vector2(0,0)
	var target_scale = base_scale
	self.scale = base_scale * hover_scale
	
	var tween = create_tween()
	tween.parallel().tween_property(self, "scale", target_scale, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _on_pressed() -> void:
	Opponent.opponent_turn()
	SignalBus.cards_dealt.emit()
	SignalBus.ended_enemy_turn.emit()
