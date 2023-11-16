extends Area2D

signal coffee_machine_broken
@export var player: CharacterBody2D
var fixed: bool = true
var interaction_time: float = 0.0
var player_in_range: bool = false


func _physics_process(delta: float) -> void:
	if player_in_range:
		if !fixed:
			Global.track_fixable(self, delta)
		elif Input.is_action_just_pressed("interact"):
			fixed = false
			emit_signal("coffee_machine_broken")
			print_debug("broken")


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		player_in_range = true


func _on_body_exited(body: Node2D) -> void:
	if body == player:
		interaction_time = 0
		player_in_range = false
