extends Area2D

signal coffee_machine_broken
signal coffee_machine_fixed
@export var player: CharacterBody2D
var fixed: bool = true
var interaction_time: float = 0.0
var player_in_range: bool = false
@onready var break_sfx_player: AudioStreamPlayer = $BreakSfxPlayer
@onready var fix_sfx_player: AudioStreamPlayer = $FixSfxPlayer
@onready var icon_break: Sprite2D = $IconBreak
@onready var icon_fix: Sprite2D = $IconFix


func _physics_process(delta: float) -> void:
	if player_in_range:
		if !fixed:
			Global.track_fixable(self, delta, "coffee_machine_fixed")
		elif Input.is_action_just_pressed("interact"):
			break_sfx_player.play()
			fixed = false
			icon_break.visible = false
			icon_fix.start_flash()
			emit_signal("coffee_machine_broken")


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		player_in_range = true
		if fixed:
			icon_break.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body == player:
		icon_break.visible = false
		interaction_time = 0
		player_in_range = false
