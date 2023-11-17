extends Node

const PLAYABLE_LEFT_EDGE: int = 0
const PLAYABLE_RIGHT_EDGE: int = 640
const PLAYABLE_TOP_EDGE: int = 0


func track_fixable(area: Area2D, delta: float) -> void:
	if Input.is_action_pressed("interact"):
		area.interaction_time += delta
		if area.interaction_time > 2:
			area.fixed = true
			area.interaction_time = 0
			print_debug("fixed")
	elif Input.is_action_just_released("interact"):
		area.interaction_time -= delta
