extends Area2D

@export var player: CharacterBody2D
var broken: bool = false
var interaction_time: float = 0.0
var player_in_range: bool = false


func _physics_process(delta: float) -> void:
	if player_in_range:
		if broken:
			if Input.is_action_pressed("interact"):
				interaction_time += delta
				if interaction_time > 2:
					broken = false
					interaction_time = 0
					print_debug("fixed")
			elif Input.is_action_just_released("interact"):
				interaction_time -= delta
		elif Input.is_action_just_pressed("interact"):
			broken = true
			print_debug("broken")


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		player_in_range = true


func _on_body_exited(body: Node2D) -> void:
	if body == player:
		interaction_time = 0
		player_in_range = false
