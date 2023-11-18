extends Node2D


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("continue"):
		Global.load_main_scene()
	elif Input.is_action_just_pressed("exit"):
		Global.load_menu_scene()
