class_name Spawner
extends Node2D

@export_range(0,100) var max_spawned_objects: int = 10
@export_range(0,100) var min_spawned_objects: int = 3
@export_range(0,100) var min_objective_items: int = 1
@export_range(0,100) var max_objective_items: int = 5

@onready var map = get_parent()

func _ready() -> void:
    spawn_items()

func spawn_items():
    var total_spawned: int = 0
    var objective_items_spawned: int = 0

    var spawn_points = get_children()
    spawn_points.shuffle()  # Randomize the spawn points order

    # Step 1: Spawn objective items until the min_objective_items is met
    while objective_items_spawned < min_objective_items:
        var spawned_in_this_pass = false
        for spawn_point in spawn_points:
            if objective_items_spawned >= min_objective_items:
                break

            if spawn_point is SpawnPoint and not spawn_point.is_item_spawned:
                if spawn_objective_item(spawn_point):
                    total_spawned += 1
                    objective_items_spawned += 1
                    spawned_in_this_pass = true

        if not spawned_in_this_pass:
            print("Warning: Could not spawn the required number of objective items.")
            break

    # Step 2: Spawn remaining items (random) until max_spawned_objects or min_spawned_objects is met
    while total_spawned < min_spawned_objects or total_spawned < max_spawned_objects:
        var spawned_in_this_pass = false
        for spawn_point in spawn_points:
            if total_spawned >= max_spawned_objects:
                break

            if spawn_point is SpawnPoint and not spawn_point.is_item_spawned:
                if total_spawned < min_spawned_objects or should_spawn(spawn_point.spawn_chance):
                    if spawn_random_item(spawn_point):
                        total_spawned += 1
                        spawned_in_this_pass = true

        if not spawned_in_this_pass:
            print("Warning: Could not spawn the required number of items.")
            break

func should_spawn(spawn_chance: float) -> bool:
    return randf() * 100 <= spawn_chance

func spawn_random_item(spawn_point: SpawnPoint) -> bool:
    var items: Array[ObjectSpawnInfo] = spawn_point.possible_items
    items.shuffle()

    var total_weight: float = 100.0
    var random_value: float = randf() * total_weight
    var current_weight: float = 0.0

    for item in items:
        current_weight += item.chance
        if random_value <= current_weight:
            var item_instance = item.item_scene.instantiate()

            if item_instance is DefaultObject:
                if item_instance.is_objective_item:
                    if min_objective_items >= max_objective_items:
                        continue

            item_instance.global_position = spawn_point.global_position
            map.call_deferred("add_child", item_instance)
            spawn_point.is_item_spawned = true
            spawn_point.item_reference = item_instance
            return true

    return false

func spawn_objective_item(spawn_point: SpawnPoint) -> bool:
    var items: Array[ObjectSpawnInfo] = spawn_point.possible_items
    items.shuffle()

    for item in items:
        var item_instance = item.item_scene.instantiate()

        if item_instance is DefaultObject:
            if item_instance.is_objective_item:
                item_instance.global_position = spawn_point.global_position
                map.call_deferred("add_child", item_instance)
                spawn_point.is_item_spawned = true
                spawn_point.item_reference = item_instance
                return true

    return false