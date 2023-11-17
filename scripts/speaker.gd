extends Area2D

signal speaker_blasted
@export var player: CharacterBody2D
var player_in_range: bool = false


func _physics_process(_delta: float) -> void:
	if player_in_range && Input.is_action_just_pressed("interact"):
		emit_signal("speaker_blasted")


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		player_in_range = true


func _on_body_exited(body: Node2D) -> void:
	if body == player:
		player_in_range = false
