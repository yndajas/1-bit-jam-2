extends Node2D

@onready var continue_prompt: RichTextLabel = $ContinuePrompt
@onready var pressed_left: Sprite2D = $PressedLeft
@onready var pressed_right: Sprite2D = $PressedRight
@onready var pressed_space: Sprite2D = $PressedSpace
@onready var pressed_z: Sprite2D = $PressedZ


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("continue"):
		Global.load_main_scene()
	elif Input.is_action_just_pressed("exit"):
		Global.load_menu_scene()

	if Input.is_action_pressed("move_left"):
		pressed_left.visible = true
	elif Input.is_action_just_released("move_left"):
		pressed_left.visible = false

	if Input.is_action_pressed("move_right"):
		pressed_right.visible = true
	elif Input.is_action_just_released("move_right"):
		pressed_right.visible = false

	if Input.is_action_pressed("jump"):
		pressed_space.visible = true
	elif Input.is_action_just_released("jump"):
		pressed_space.visible = false

	if Input.is_action_just_released("interact"):
		pressed_z.visible = false
	elif Input.is_action_pressed("interact"):
		pressed_z.visible = true


func _on_timer_timeout() -> void:
	continue_prompt.visible = true
