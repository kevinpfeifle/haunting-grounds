class_name SpawnPoint
extends Marker2D

@export var spawn_chance: float = 50.0
@export var possible_items: Array[ObjectSpawnInfo] = []
var is_item_spawned: bool = false;
var item_reference: DefaultObject

func _ready():
    validate_chances()

# Optional: Called every time something changes in the editor (for immediate feedback)
func _notification(what):
    if what == NOTIFICATION_EDITOR_POST_SAVE:
        validate_chances()

# Validate that the total chance of all items adds up to 100
func validate_chances() -> void:
    var total_chance: float = 0.0
    for item in possible_items:
        total_chance += item.chance

    if total_chance != 100.0:
        push_error("Total spawn chance of all items in 'possible_items' must equal 100%. Current total: %f" % total_chance)