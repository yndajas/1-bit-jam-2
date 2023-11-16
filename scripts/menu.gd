extends Node2D

@onready var sprite: AnimatedSprite2D = $PlayerSprite


func _ready() -> void:
	sprite.play()


func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("start_game"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	elif Input.is_action_just_pressed("exit") and OS.has_feature("pc"):
		get_tree().quit()
