extends Node2D

@onready var sprite: AnimatedSprite2D = $PlayerSprite

func _ready() -> void:
	sprite.play()
