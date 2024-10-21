class_name Spawner
extends Node2D

@onready var map = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_items()

func spawn_items():
	for spawn_point in get_children():
		if spawn_point is SpawnPoint:
			if should_spawn(spawn_point.spawn_chance):
				spawn_random_item(spawn_point)

func should_spawn(spawn_chance: float) -> bool:
	return randf() * 100 <= spawn_chance

func spawn_random_item(spawn_point: SpawnPoint) -> void:
	var items: Array[ObjectSpawnInfo] = spawn_point.possible_items

	var total_weight: float = 100.0
	var random_value: float = randf() * total_weight
	var current_weight: float = 0.0

	for item in items:
		current_weight += item.chance
		if random_value <= current_weight:
			var item_instance = item.item_scene.instantiate()
			item_instance.global_position = spawn_point.global_position
			map.call_deferred("add_child", item_instance)
			break
