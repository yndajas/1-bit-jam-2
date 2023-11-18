extends Node

const CUSTOMER_SPEED: float = 50.0
const PLAYABLE_LEFT_EDGE: int = 0
const PLAYABLE_RIGHT_EDGE: int = 640
const PLAYABLE_TOP_EDGE: int = 0
var current_level: int = -1
var level_scores: Array[int] = [0]


func track_fixable(area: Area2D, delta: float, signal_to_emit: String) -> void:
	if Input.is_action_pressed("interact"):
		area.fix_sfx_player.play(area.fix_sfx_player.get_playback_position())
		area.interaction_time += delta
		if area.interaction_time > 2:
			area.fixed = true
			area.emit_signal(signal_to_emit)
			area.interaction_time = 0
	elif Input.is_action_just_released("interact"):
		area.interaction_time -= delta
