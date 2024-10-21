class_name DefaultObject
extends StaticBody2D

@export var object_name: String = "Default Object"
@export var description: String = "Currently an urn, but doesn't have to be."

@export var is_objective_item: bool = false

func interact_player() -> void:
    print("Interacting with: %s" % object_name)

func interact_npc() -> void: 
    print("NPC Interacted with: %s" % object_name)

func inspect() -> void:
    print("Object Name: %s" % object_name)
    print("Description: %s" % description)
    if (is_objective_item):
        print("This item is of much significance to you. Make sure the living don't destroy it!")
    else:
        print("This item is not of much significance to you.")

func _on_area_2d_body_entered(body: Node) -> void:
    if body.name == "Character":
        interact_player()
    # elif body is NPC:
    #     interact_npc()