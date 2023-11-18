extends Node2D

var stars_filled: int = 0
@onready var filled_stars: Array[Sprite2D] = [$FilledStar0, $FilledStar1, $FilledStar2]
@onready var sfx_player: AudioStreamPlayer = $StarFillTimer/SfxPlayer
@onready var star_fill_timer: Timer = $StarFillTimer


func _ready() -> void:
	print_debug(Global.level_scores[Global.current_level])
	start_timer_if_fill_needed()


func start_timer_if_fill_needed() -> void:
	if stars_filled < Global.level_scores[Global.current_level]:
		var wait_time: float = 0.75 if not stars_filled else 0.5
		star_fill_timer.start(wait_time)


func _on_star_fill_timer_timeout() -> void:
	filled_stars[stars_filled].visible = true
	sfx_player.play()
	stars_filled += 1
	start_timer_if_fill_needed()
