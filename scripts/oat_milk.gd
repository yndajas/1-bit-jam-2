extends Area2D

signal oat_milk_drunk
@export var player: CharacterBody2D
var drunk: bool = false
var player_in_range: bool = false
@onready var icon_drink: Sprite2D = $IconDrink


func _physics_process(_delta: float) -> void:
	if player_in_range && !drunk && Input.is_action_just_pressed("interact"):
		drunk = true
		icon_drink.visible = false
		emit_signal("oat_milk_drunk")


func on_spillage_cleaned() -> void:
	drunk = false


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		player_in_range = true
		if !drunk:
			icon_drink.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body == player:
		icon_drink.visible = false
		player_in_range = false
