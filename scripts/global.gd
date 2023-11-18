extends Node

const CUSTOMER_SPEED: float = 50.0
const LEVEL_SPAWNS: Array[Array] = [
	[
		{"customer_type_index": 0, "wait_time": 3.0},
		{"customer_type_index": 1, "wait_time": 9.0},
		{"customer_type_index": 2, "wait_time": 9.0},
		{"customer_type_index": 0, "wait_time": 9.0},
	],
	[
		{"customer_type_index": 0, "wait_time": 3.0},
		{"customer_type_index": 1, "wait_time": 5.0},
		{"customer_type_index": 2, "wait_time": 6.0},
		{"customer_type_index": 1, "wait_time": 7.0},
		{"customer_type_index": 1, "wait_time": 7.0},
		{"customer_type_index": 0, "wait_time": 5.0},
		{"customer_type_index": 2, "wait_time": 6.0},
		{"customer_type_index": 0, "wait_time": 4.0},
	],
	[
		{"customer_type_index": 0, "wait_time": 3.0},
		{"customer_type_index": 0, "wait_time": 5.0},
		{"customer_type_index": 2, "wait_time": 3.0},
		{"customer_type_index": 0, "wait_time": 4.0},
		{"customer_type_index": 1, "wait_time": 3.0},
		{"customer_type_index": 2, "wait_time": 2.0},
		{"customer_type_index": 0, "wait_time": 5.0},
		{"customer_type_index": 1, "wait_time": 3.0},
		{"customer_type_index": 1, "wait_time": 2.0},
		{"customer_type_index": 1, "wait_time": 3.0},
		{"customer_type_index": 2, "wait_time": 2.0},
		{"customer_type_index": 1, "wait_time": 4.0},
	],
	[
		{"customer_type_index": 2, "wait_time": 3.0},
		{"customer_type_index": 2, "wait_time": 2.0},
		{"customer_type_index": 1, "wait_time": 4.0},
		{"customer_type_index": 2, "wait_time": 2.0},
		{"customer_type_index": 1, "wait_time": 2.0},
		{"customer_type_index": 0, "wait_time": 3.0},
		{"customer_type_index": 2, "wait_time": 4.0},
		{"customer_type_index": 2, "wait_time": 2.0},
		{"customer_type_index": 0, "wait_time": 4.0},
		{"customer_type_index": 1, "wait_time": 3.0},
		{"customer_type_index": 2, "wait_time": 2.0},
		{"customer_type_index": 0, "wait_time": 2.0},
		{"customer_type_index": 0, "wait_time": 2.0},
		{"customer_type_index": 1, "wait_time": 4.0},
		{"customer_type_index": 1, "wait_time": 2.0},
		{"customer_type_index": 2, "wait_time": 5.0},
	]
]
const PLAYABLE_LEFT_EDGE: int = 0
const PLAYABLE_RIGHT_EDGE: int = 640
const PLAYABLE_TOP_EDGE: int = 0
var current_level: int = 0
var level_scores: Array[int] = [0, 0, 0, 0]


func load_main_scene() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func on_final_level() -> bool:
	return current_level == LEVEL_SPAWNS.size() - 1


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
