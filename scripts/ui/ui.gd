extends CanvasLayer  # Assuming the UI node extends Control or a similar base class

@export var max_hallowedness: int = 100
@export var hallowedness_hit: float = 20
@export var map_name: String = "Mourningwood Manor"

@onready var hallowedness_bar = %HallowednessBar
@onready var total_items_label = %TotalItemsLabel
@onready var objective_items_label = %ObjectiveItemsLabel

var total_spawned: int = 0
var objective_items_spawned: int = 0
var current_hallowedness: int

func _ready() -> void:
	current_hallowedness = max_hallowedness
	hallowedness_bar.value = max_hallowedness

	get_tree().connect("node_added", Callable(self, "_on_node_added"))

func _on_node_added(node: Node) -> void:
	if node is DefaultObject:
		print("DefaultObject added to UI: %s" % node.object_name)
		total_spawned += 1

		if node.is_objective_item:
			objective_items_spawned += 1
		
		node.connect("destroyed", Callable(self, "on_item_destroyed"))
		
		total_items_label.text = "Total Items: %d" % total_spawned
		objective_items_label.text = "Objective Items: %d" % objective_items_spawned

func on_item_destroyed(node: DefaultObject) -> void:
	if total_spawned > 0:
		total_spawned -= 1
		total_items_label.text = "Total Items: %d" % total_spawned
	if node.is_objective_item:
		if objective_items_spawned > 0:
			objective_items_spawned -= 1
			objective_items_label.text = "Objective Items: %d" % objective_items_spawned
			
			decrement_hallowedness()

func decrement_hallowedness() -> void:
	var decrement_value = max_hallowedness * (hallowedness_hit / 100)
	current_hallowedness = max(0, current_hallowedness - decrement_value)
	
	hallowedness_bar.value = current_hallowedness
