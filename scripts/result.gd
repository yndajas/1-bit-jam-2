extends Node2D

var stars_filled: int = 0
@onready var continue_prompt: RichTextLabel = $ContinuePrompt
@onready var continue_prompt_timer: Timer = $ContinuePrompt/Timer
@onready var filled_stars: Array[Sprite2D] = [$FilledStar0, $FilledStar1, $FilledStar2]
@onready var sfx_player: AudioStreamPlayer = $StarFillTimer/SfxPlayer
@onready var star_fill_timer: Timer = $StarFillTimer


func _ready() -> void:
	print_debug(Global.level_scores[Global.current_level])
	start_timer()


func fill_needed() -> bool:
	return stars_filled < Global.level_scores[Global.current_level]


func start_timer() -> void:
	var wait_time: float = 0.75 if not stars_filled else 0.5
	star_fill_timer.start(wait_time)


func _on_continue_prompt_timer_timeout() -> void:
	continue_prompt.visible = true


func _on_star_fill_timer_timeout() -> void:
	filled_stars[stars_filled].visible = true
	sfx_player.play()
	stars_filled += 1
	if fill_needed():
		start_timer()
	else:
		continue_prompt_timer.start()
