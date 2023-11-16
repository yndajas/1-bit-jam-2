extends CharacterBody2D

const SPEED: float = 200.0
const JUMP_VELOCITY: float = -350.0

var direction: float = 0.0
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	direction = Input.get_axis("move_left", "move_right")
	set_animation()
	set_orientation()
	set_movement(delta)
	move_and_slide()


func set_animation() -> void:
	if not is_on_floor():
		sprite.play("jump")
	elif direction:
		sprite.play("run")
	else:
		sprite.play("stand")


func set_movement(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY

	if direction:
		var target_velocity_x := direction * SPEED
		velocity.x = move_toward(velocity.x, target_velocity_x, SPEED / 10)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED / 2)


func set_orientation() -> void:
	if direction:
		if direction == -1:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
