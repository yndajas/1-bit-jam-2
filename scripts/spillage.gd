extends Area2D

signal spillage_cleaned
@export var player: CharacterBody2D
var fixed: bool = false
var interaction_time: float = 0.0
var player_in_range: bool = false
@onready var icon_clean: Sprite2D = $IconClean
@onready var fix_sfx_player: AudioStreamPlayer = $FixSfxPlayer


func _physics_process(delta: float) -> void:
	if fixed:
		self.queue_free()
	elif player_in_range && !fixed:
		Global.track_fixable(self, delta, "spillage_cleaned")


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		player_in_range = true


func _on_body_exited(body: Node2D) -> void:
	if body == player:
		interaction_time = 0
		player_in_range = false


func _on_timer_timeout() -> void:
	icon_clean.visible = !icon_clean.visible
