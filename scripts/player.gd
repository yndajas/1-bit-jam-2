extends CharacterBody2D

enum Edge { LEFT, RIGHT }
const SPEED: float = 200.0
const JUMP_VELOCITY: float = -350.0
var direction: float = 0.0
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var edge_offset: float = (
	(
		$AnimatedSprite2D
		. get_sprite_frames()
		. get_frame_texture($AnimatedSprite2D.animation, $AnimatedSprite2D.frame)
		. get_size()[0]
	)
	/ 2.0
)
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	direction = Input.get_axis("move_left", "move_right")
	set_animation()
	set_orientation()
	set_movement(delta)
	move_and_slide()
	reset_if_beyond_edge()


func has_hit_edge(edge: int) -> bool:
	if edge == Edge.LEFT:
		return x_position() - edge_offset < Global.PLAYABLE_LEFT_EDGE

	return x_position() + edge_offset > Global.PLAYABLE_RIGHT_EDGE


func reset_if_beyond_edge() -> void:
	if has_hit_edge(Edge.LEFT):
		reset_to_edge(Edge.LEFT)
	elif has_hit_edge(Edge.RIGHT):
		reset_to_edge(Edge.RIGHT)


func reset_to_edge(edge: int) -> void:
	var target_x_position: float

	if edge == Edge.LEFT:
		target_x_position = ceilf(Global.PLAYABLE_LEFT_EDGE + edge_offset)
	else:
		target_x_position = floor(Global.PLAYABLE_RIGHT_EDGE - edge_offset)

	self.global_position = Vector2(target_x_position, y_position())


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


func x_position() -> float:
	return self.global_position[0]


func y_position() -> float:
	return self.global_position[1]
