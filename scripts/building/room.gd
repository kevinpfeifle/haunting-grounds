class_name Room
extends Node2D

var room_area: Area2D
var animation_player: AnimationPlayer

var front_walls: TileMapLayer
var back_walls: TileMapLayer
var ceiling_shadow: TileMapLayer

func _ready():
	front_walls = get_node("FrontWalls")
	back_walls = get_node("BackWalls")
	ceiling_shadow = get_node("CeilingShadow")
	room_area = get_node("RoomArea")
	animation_player = get_node("AnimationPlayer")

func _on_room_area_body_entered():
	animation_player.play("front_walls_fade_out")

func _on_room_area_body_exited():
	animation_player.play("front_walls_fade_in")