extends Area2D

signal speaker_blasted
@export var player: CharacterBody2D
var player_in_range: bool = false
@onready var icon_blast: Sprite2D = $IconBlast


func _physics_process(_delta: float) -> void:
	if player_in_range && Input.is_action_just_pressed("interact"):
		emit_signal("speaker_blasted")


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		icon_blast.visible = true
		player_in_range = true


func _on_body_exited(body: Node2D) -> void:
	if body == player:
		icon_blast.visible = false
		player_in_range = false
