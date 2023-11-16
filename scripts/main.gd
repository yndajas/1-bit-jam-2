extends Node2D

var spillage_scene: PackedScene = preload("res://scenes/spillage.tscn")
var time: float = 960.0
@onready var clock_text: RichTextLabel = $ClockText
@onready var counter_half_width: int = floori($Counter.get_rect().size[0] / 2.0 * $Counter.scale.x)
@onready var counter_left_edge: int = floori($Counter.position.x - counter_half_width)
@onready var counter_right_edge: int = floori($Counter.position.x + counter_half_width)
@onready var oat_milk: Area2D = $OatMilk
@onready var player: CharacterBody2D = $Player
@onready var top_floor_left_edge = floori(
	$TopFloor.position.x - $TopFloor/Sprite2D.get_rect().size[0] / 2.0 * $TopFloor.scale.x
)


func _ready() -> void:
	oat_milk.connect("oat_milk_drunk", on_oat_milk_drunk)


func _physics_process(delta: float) -> void:
	time += delta
	update_clock()

	if Input.is_action_pressed("exit"):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")


func on_oat_milk_drunk() -> void:
	var spillage: Area2D = spillage_scene.instantiate()
	var spillage_half_width: int = ceili(
		spillage.get_node("Sprite2D").get_rect().size[0] / 2.0 * spillage.scale.x
	)
	spillage.global_position = (
		[
			spillage_position_bottom_left(spillage_half_width),
			spillage_position_bottom_right(spillage_half_width),
			spillage_position_top(spillage_half_width)
		]
		. pick_random()
	)
	spillage.player = player
	spillage.connect("spillage_cleaned", on_spillage_cleaned)
	oat_milk.add_sibling.call_deferred(spillage)


func on_spillage_cleaned() -> void:
	oat_milk.on_spillage_cleaned()


func spillage_position_bottom_left(spillage_half_width: int) -> Vector2:
	return Vector2(
		randi_range(
			Global.PLAYABLE_LEFT_EDGE + spillage_half_width, counter_left_edge - spillage_half_width
		),
		336
	)


func spillage_position_bottom_right(spillage_half_width: int) -> Vector2:
	return Vector2(
		randi_range(
			counter_right_edge + spillage_half_width,
			Global.PLAYABLE_RIGHT_EDGE - spillage_half_width
		),
		336
	)


func spillage_position_top(spillage_half_width: int) -> Vector2:
	return Vector2(
		randi_range(
			top_floor_left_edge + spillage_half_width,
			Global.PLAYABLE_RIGHT_EDGE - spillage_half_width
		),
		154
	)


func update_clock() -> void:
	var hours: int = floori(time / 60)
	var minutes: int = int(time) % 60
	clock_text.text = "%02d" % hours + ":" + "%02d" % minutes
