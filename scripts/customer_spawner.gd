extends Node2D

const SPEED: float = 50.0
@export var ground_floor: StaticBody2D
var customer_scenes: Array[PackedScene] = [
	preload("res://scenes/old.tscn"),
	preload("res://scenes/professional.tscn"),
	preload("res://scenes/vegan.tscn")
]
var next_spawn: Dictionary
var spawn_queue: Array = [
	{"customer_type_index": 0, "wait_time": 3.0},
	{"customer_type_index": 1, "wait_time": 5.0},
	{"customer_type_index": 2, "wait_time": 6.0},
	{"customer_type_index": 1, "wait_time": 8.0},
	{"customer_type_index": 1, "wait_time": 9.0},
	{"customer_type_index": 0, "wait_time": 9.0},
	{"customer_type_index": 2, "wait_time": 6.0},
	{"customer_type_index": 0, "wait_time": 4.0},
]
var spawned: Dictionary = {"spawn_dictionaries": [], "customer_sprites": [[], [], []]}
@onready var ground_floor_top_edge: int = floori(
	(
		ground_floor.position.y
		- ground_floor.get_node("Sprite2D").get_rect().size[1] / 2.0 * ground_floor.scale.y
	)
)
@onready var timer: Timer = get_node("Timer")


func _ready() -> void:
	queue_next_spawn()


func _physics_process(delta: float) -> void:
	var spawned_index = 0
	var sprite_indices: Array = [0, 0, 0]

	for spawn_dictionary in spawned.spawn_dictionaries:
		var customer_type_index: int = spawn_dictionary.customer_type_index
		var sprites_of_type: Array = spawned.customer_sprites[customer_type_index]
		var sprite_index: int = sprite_indices[customer_type_index]
		var sprite: Sprite2D = sprites_of_type[sprite_index]

		var playable_edge_gap: int = Global.PLAYABLE_RIGHT_EDGE - 24
		var half_customer_slot_width: int = floori(16 * sprite.scale.x)
		var queue_position_offset: int = floori(32 * sprite.scale.x * spawned_index)
		sprite.global_position.x = ceili(
			move_toward(
				sprite.global_position.x,
				playable_edge_gap - half_customer_slot_width - queue_position_offset,
				SPEED * delta
			)
		)

		spawned_index += 1
		sprite_indices[customer_type_index] += 1


func queue_next_spawn() -> void:
	next_spawn = spawn_queue.pop_front()
	timer.wait_time = next_spawn.wait_time
	timer.start()


func spawn_customer() -> void:
	var customer_type_index: int = next_spawn.customer_type_index
	var new_customer: Sprite2D = customer_scenes[customer_type_index].instantiate()
	var new_customer_half_width: int = ceili(
		new_customer.get_rect().size[0] / 2.0 * new_customer.scale.x
	)
	var new_customer_half_height: int = floori(
		new_customer.get_rect().size[1] / 2.0 * new_customer.scale.y
	)
	new_customer.global_position = Vector2(
		Global.PLAYABLE_LEFT_EDGE - new_customer_half_width,
		ground_floor_top_edge - new_customer_half_height
	)
	timer.add_sibling.call_deferred(new_customer)

	spawned.spawn_dictionaries.push_back(next_spawn)
	spawned.customer_sprites[customer_type_index].push_back(new_customer)


func _on_timer_timeout() -> void:
	spawn_customer()
	if spawn_queue.size():
		queue_next_spawn()
