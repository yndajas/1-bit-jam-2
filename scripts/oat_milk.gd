extends Area2D

signal oat_milk_drunk
@export var player: CharacterBody2D
var drunk: bool = false
var player_in_range: bool = false


func _physics_process(_delta: float) -> void:
	if player_in_range && !drunk && Input.is_action_just_pressed("interact"):
		drunk = true
		emit_signal("oat_milk_drunk")
		print_debug("oat milk drunk")
		# render vomit


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		player_in_range = true


func _on_body_exited(body: Node2D) -> void:
	if body == player:
		player_in_range = false
