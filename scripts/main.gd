extends Node2D

var customer_count: int = 0
var fixables_count: int = 0
var level_finished: bool = false
var spillage_scene: PackedScene = preload("res://scenes/spillage.tscn")
var window_crack_scene: PackedScene = preload("res://scenes/window_crack.tscn")
var time: float = 960.0
@onready var ground_floor_top_edge: int = floori(
	$GroundFloor.position.y - $GroundFloor/Sprite2D.get_rect().size[1] / 2.0 * $GroundFloor.scale.y
)
@onready var clock_text: RichTextLabel = $ClockText
@onready var clock_text_bottom_edge: int = ceili(clock_text.position.y + clock_text.size.y)
@onready var coffee_machine: Area2D = $CoffeeMachine
@onready var counter_half_width: int = floori($Counter.get_rect().size[0] / 2.0 * $Counter.scale.x)
@onready var counter_left_edge: int = floori($Counter.position.x - counter_half_width)
@onready var counter_right_edge: int = ceili($Counter.position.x + counter_half_width)
@onready var customer_spawner: Node2D = $CustomerSpawner
@onready var day_text: RichTextLabel = $DayText
@onready var day_text_bottom_edge: int = ceili(day_text.position.y + day_text.size.y)
@onready var oat_milk: Area2D = $OatMilk
@onready var player: CharacterBody2D = $Player
@onready var speaker: Area2D = $Speaker
@onready var step_0_right_edge: int = floori(
	$Step0.position.x + $Step0/Sprite2D.get_rect().size[0] / 2.0 * $Step2.scale.x
)
@onready var step_2_top_edge: int = floori(
	$Step2.position.y - $Step2/Sprite2D.get_rect().size[1] / 2.0 * $Step2.scale.y
)
@onready var top_floor_sprite_rect = $TopFloor/Sprite2D.get_rect()
@onready var top_floor_bottom_edge: int = floori(
	$TopFloor.position.y + top_floor_sprite_rect.size[1] / 2.0 * $TopFloor.scale.y
)
@onready var top_floor_left_edge: int = floori(
	$TopFloor.position.x - top_floor_sprite_rect.size[0] / 2.0 * $TopFloor.scale.x
)
@onready var top_floor_top_edge: int = floori(
	$TopFloor.position.y - top_floor_sprite_rect.size[1] / 2.0 * $TopFloor.scale.y
)


func _ready() -> void:
	day_text.text = Global.current_level_name()
	coffee_machine.connect("coffee_machine_broken", on_coffee_machine_broken)
	coffee_machine.connect("coffee_machine_fixed", on_coffee_machine_fixed)
	customer_spawner.connect("customer_arrived", on_customer_arrived)
	customer_spawner.connect("customer_left", on_customer_left)
	oat_milk.connect("oat_milk_drunk", on_oat_milk_drunk)
	speaker.connect("speaker_blasted", on_speaker_blasted)


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		Global.load_menu_scene()

	time += delta
	update_clock()
	check_if_level_finished(delta)

	if level_finished:
		get_tree().change_scene_to_file("res://scenes/result.tscn")


func check_if_level_finished(delta: float) -> void:
	if time >= 1020.0 and in_winnable_state():
		if time - delta <= 1020.0:
			Global.level_scores[Global.current_level] = 3
			level_finished = true
		elif time < 1030.0:
			Global.level_scores[Global.current_level] = 2
			level_finished = true
		elif time < 1050.0:
			Global.level_scores[Global.current_level] = 1
			level_finished = true
	elif time >= 1050.0:
		Global.level_scores[Global.current_level] = 0
		level_finished = true


func in_winnable_state() -> bool:
	return customer_count == 0 and fixables_count == 0


func on_coffee_machine_broken() -> void:
	fixables_count += 1


func on_coffee_machine_fixed() -> void:
	coffee_machine.icon_fix.stop_flash()
	coffee_machine.icon_break.visible = true
	fixables_count -= 1


func on_customer_arrived() -> void:
	customer_count += 1


func on_customer_left() -> void:
	customer_count -= 1


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
	fixables_count += 1


func on_speaker_blasted() -> void:
	var window_crack: Area2D = window_crack_scene.instantiate()
	var window_crack_sprite_rect = window_crack.get_node("Sprite2D").get_rect()
	var window_crack_half_width: int = ceili(
		window_crack_sprite_rect.size[0] / 2.0 * window_crack.scale.x
	)
	var window_crack_half_height: int = ceili(
		window_crack_sprite_rect.size[1] / 2.0 * window_crack.scale.y
	)
	window_crack.global_position = (
		[
			window_crack_position_top_left(window_crack_half_width, window_crack_half_height),
			window_crack_position_top_right(window_crack_half_width, window_crack_half_height),
			window_crack_position_bottom_left(window_crack_half_width, window_crack_half_height),
			window_crack_position_bottom_right(window_crack_half_width, window_crack_half_height)
		]
		. pick_random()
	)
	window_crack.player = player
	window_crack.connect("window_crack_fixed", on_window_crack_fixed)
	speaker.add_sibling.call_deferred(window_crack)
	fixables_count += 1


func on_spillage_cleaned() -> void:
	oat_milk.on_spillage_cleaned()
	fixables_count -= 1


func on_window_crack_fixed() -> void:
	fixables_count -= 1


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


func window_crack_position_bottom_left(
	window_crack_half_width: int, window_crack_half_height: int
) -> Vector2:
	return Vector2(
		randi_range(
			step_0_right_edge + window_crack_half_width + 24,
			counter_left_edge - window_crack_half_width - 24
		),
		randi_range(
			top_floor_bottom_edge + window_crack_half_height + 24,
			ground_floor_top_edge - window_crack_half_height - 24
		)
	)


func window_crack_position_bottom_right(
	window_crack_half_width: int, window_crack_half_height: int
) -> Vector2:
	return Vector2(
		randi_range(
			counter_right_edge + window_crack_half_width + 24,
			Global.PLAYABLE_RIGHT_EDGE - window_crack_half_width - 24
		),
		randi_range(
			top_floor_bottom_edge + window_crack_half_height + 24,
			ground_floor_top_edge - window_crack_half_height - 24
		)
	)


func window_crack_position_top_left(
	window_crack_half_width: int, window_crack_half_height: int
) -> Vector2:
	return Vector2(
		randi_range(
			Global.PLAYABLE_LEFT_EDGE + window_crack_half_width + 24,
			top_floor_left_edge - window_crack_half_width - 24
		),
		randi_range(
			day_text_bottom_edge + window_crack_half_height + 24,
			step_2_top_edge - window_crack_half_height - 24
		)
	)


func window_crack_position_top_right(
	window_crack_half_width: int, window_crack_half_height: int
) -> Vector2:
	return Vector2(
		randi_range(
			top_floor_left_edge + window_crack_half_width,
			Global.PLAYABLE_RIGHT_EDGE - window_crack_half_width - 24
		),
		randi_range(
			clock_text_bottom_edge + window_crack_half_height + 24,
			top_floor_top_edge - window_crack_half_height - 24
		)
	)
