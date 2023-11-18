extends Node2D


func _ready() -> void:
	print_debug(Global.level_scores[Global.current_level])
	# Global.current_level += 1
