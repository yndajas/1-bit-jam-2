extends Node2D

var stars_filled: int = 0
@onready var continue_prompt: RichTextLabel = $ContinuePrompt
@onready var continue_prompt_timer: Timer = $ContinuePrompt/Timer
@onready var credits: RichTextLabel = $Credits
@onready var credits_timer: Timer = $Credits/Timer
@onready var end_text: RichTextLabel = $EndText
@onready var end_text_timer: Timer = $EndText/Timer
@onready var filled_stars: Array[Sprite2D] = [$FilledStar0, $FilledStar1, $FilledStar2]
@onready var sfx_player: AudioStreamPlayer = $StarFillTimer/SfxPlayer
@onready var star_fill_timer: Timer = $StarFillTimer


func _ready() -> void:
	if star_fill_needed():
		start_star_fill_timer()
	else:
		render_continue_or_credits()


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		Global.load_menu_scene()

	if (
		not star_fill_needed()
		and not Global.on_final_level()
		and Input.is_action_just_pressed("continue")
	):
		Global.current_level += 1
		Global.load_main_scene()


func render_continue_or_credits() -> void:
	if Global.on_final_level():
		credits_timer.start()
	else:
		if score() > 0:
			continue_prompt_timer.start()
		else:
			continue_prompt.visible = true


func score() -> int:
	return Global.level_scores[Global.current_level]


func star_fill_needed() -> bool:
	return stars_filled < score()


func start_star_fill_timer() -> void:
	var wait_time: float = 0.75 if not stars_filled else 0.5
	star_fill_timer.start(wait_time)


func _on_continue_prompt_timer_timeout() -> void:
	continue_prompt.visible = true


func _on_credits_timer_timeout() -> void:
	credits.visible = true


func _on_star_fill_timer_timeout() -> void:
	filled_stars[stars_filled].visible = true
	sfx_player.play()
	stars_filled += 1
	if star_fill_needed():
		start_star_fill_timer()
	else:
		render_continue_or_credits()
