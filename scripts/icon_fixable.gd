extends Sprite2D

@onready var timer: Timer = $Timer


func stop_flash() -> void:
	timer.stop()
	self.visible = false


func start_flash() -> void:
	self.visible = true
	timer.start()


func _on_timer_timeout() -> void:
	self.visible = !self.visible
