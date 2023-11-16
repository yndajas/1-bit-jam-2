extends Node2D

var time: float = 960.0
@onready var clock_text: RichTextLabel = $ClockText


func _physics_process(delta: float) -> void:
	time += delta
	update_clock()


func update_clock() -> void:
	var hours: int = floori(time / 60)
	var minutes: int = int(time) % 60
	clock_text.text = "%02d" % hours + ":" + "%02d" % minutes
