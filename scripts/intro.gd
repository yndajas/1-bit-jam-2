extends Node2D


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("continue"):
		get_tree().change_scene_to_file("res://scenes/tutorial.tscn")
	elif Input.is_action_just_pressed("exit"):
		Global.load_menu_scene()
