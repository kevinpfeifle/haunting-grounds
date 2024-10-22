class_name DefaultObject
extends StaticBody2D

@onready var anim_sprite = $AnimatedSprite2D
@onready var sprite = $Sprite2D

@export var object_name: String = "Default Object"
@export var description: String = "Currently an urn, but doesn't have to be."

@export var is_objective_item: bool = false

var is_destroyed: bool = false

signal destroyed(object: DefaultObject)

func _ready() -> void:
    if anim_sprite != null:
        sprite.visible = false

func destroy() -> void:
    if not is_destroyed:
        is_destroyed = true
        destroyed.emit(self)

func interact() -> void:
    print("Interacting with: %s" % object_name)

func contact_player() -> void:
    print("Contacted with: %s" % object_name)

func contact_npc() -> void: 
    print("Enemy contact with: %s" % object_name)

func inspect() -> void:
    print("Object Name: %s" % object_name)
    print("Description: %s" % description)
    if (is_objective_item):
        print("This item is of much significance to you. Make sure the living don't destroy it!")
    else:
        print("This item is not of much significance to you.")

func _on_area_2d_body_entered(body: Node) -> void:
    if body is Character:
        contact_player()
    elif body is Enemy:
        contact_npc()

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
    if event.is_action_pressed("interact"):
        interact()
    if event.is_action_pressed("inspect"):
        inspect()