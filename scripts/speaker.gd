extends Area2D

signal speaker_on
@export var player: CharacterBody2D
var on: bool = false
var player_in_range: bool = false


func _physics_process(_delta: float) -> void:
	if player_in_range && !on && Input.is_action_just_pressed("interact"):
		on = true
		emit_signal("speaker_on")
		print_debug("speaker on")
		# render window crack


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		player_in_range = true


func _on_body_exited(body: Node2D) -> void:
	if body == player:
		player_in_range = false
