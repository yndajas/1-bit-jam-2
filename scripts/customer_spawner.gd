extends Node2D

signal customer_arrived
signal customer_left
@export var coffee_machine: Area2D
@export var oat_milk: Area2D
@export var speaker: Area2D
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
	coffee_machine.connect("coffee_machine_broken", on_coffee_machine_broken)
	oat_milk.connect("oat_milk_drunk", on_oat_milk_drunk)
	speaker.connect("speaker_blasted", on_speaker_blasted)


func _physics_process(delta: float) -> void:
	move_customers(delta)


func move_customers(delta: float) -> void:
	var spawned_index = 0
	var sprite_indices: Array = [0, 0, 0]

	for spawn_dictionary in spawned.spawn_dictionaries:
		var customer_type_index: int = spawn_dictionary.customer_type_index
		var sprites_of_type: Array = spawned.customer_sprites[customer_type_index]
		var sprite_index: int = sprite_indices[customer_type_index]
		var sprite: Sprite2D = sprites_of_type[sprite_index]

		sprite.global_position.x = ceili(
			move_toward(
				sprite.global_position.x,
				maximum_queue_position(sprite, spawned_index),
				Global.CUSTOMER_SPEED * delta
			)
		)
		spawned_index += 1
		sprite_indices[customer_type_index] += 1


func on_coffee_machine_broken() -> void:
	remove_customer(1)


func on_customer_left() -> void:
	emit_signal("customer_left")


func on_oat_milk_drunk() -> void:
	remove_customer(2)


func on_speaker_blasted() -> void:
	remove_customer(0)


func queue_next_spawn() -> void:
	next_spawn = spawn_queue.pop_front()
	timer.wait_time = next_spawn.wait_time
	timer.start()


func maximum_queue_position(sprite: Sprite2D, spawned_index: int) -> int:
	var queue_position_offset: int = floori(32 * sprite.scale.x * spawned_index)
	return floori(speaker.global_position.x) - queue_position_offset


func remove_customer(customer_type_index: int) -> void:
	if spawned.customer_sprites[customer_type_index].size():
		var sprite: Sprite2D = spawned.customer_sprites[customer_type_index].pop_front()
		sprite.connect("customer_left", on_customer_left)
		sprite.leave()

		var spawn_dictionary_index: int = 0
		var found: bool = false
		while not found:
			var spawn_dictionary: Dictionary = spawned.spawn_dictionaries[spawn_dictionary_index]
			if spawn_dictionary.customer_type_index == customer_type_index:
				found = true
				spawned.spawn_dictionaries.pop_at(spawn_dictionary_index)
			else:
				spawn_dictionary_index += 1


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
		min(
			Global.PLAYABLE_LEFT_EDGE - new_customer_half_width,
			maximum_queue_position(new_customer, spawned.spawn_dictionaries.size())
		),
		ground_floor_top_edge - new_customer_half_height
	)
	timer.add_sibling.call_deferred(new_customer)

	spawned.spawn_dictionaries.push_back(next_spawn)
	spawned.customer_sprites[customer_type_index].push_back(new_customer)

	emit_signal("customer_arrived")


func _on_timer_timeout() -> void:
	spawn_customer()
	if spawn_queue.size():
		queue_next_spawn()
