extends Sprite2D

signal customer_left
var leaving: bool = false
@onready var half_width: float = self.get_rect().size[0] / 2.0 * self.scale.x


func _physics_process(delta: float) -> void:
	if leaving:
		self.global_position.x += ceili(Global.CUSTOMER_SPEED * delta)

		if is_off_screen_right():
			emit_signal("customer_left")
			self.queue_free()


func leave() -> void:
	leaving = true


func is_off_screen_right() -> bool:
	return self.global_position.x - half_width > Global.PLAYABLE_RIGHT_EDGE
