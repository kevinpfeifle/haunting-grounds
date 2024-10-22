class_name Room
extends Node2D

var OUTSIDE_Y_SORT: int = -35
var INSIDE_Y_SORT: int = 120

var room_area: Area2D
var animation_player: AnimationPlayer

var front_walls: TileMapLayer
var back_walls: TileMapLayer
var ceiling_shadow: TileMapLayer

func _ready():
	room_area = get_node("RoomArea")
	animation_player = get_node("AnimationPlayer")
	front_walls = get_node("FrontWalls")
	back_walls = get_node("BackWalls")
	ceiling_shadow = get_node("CeilingShadow")

func _on_room_area_body_entered(body: Node2D):
	if body.name == "Character":
		# Play the fade out animations for the walls and any doors.
		animation_player.play("front_walls_fade_out")
		# for child in front_walls.get_children():
		# 	if child is Door:
		# 		child.animation_player.play("door_fade_out")
		# Swaps between the two phyics layers and y-sort values for the bottom walls of a room.
		front_walls.tile_set.set_physics_layer_collision_layer(0, 0)
		front_walls.tile_set.set_physics_layer_collision_mask(0, 0)
		front_walls.tile_set.set_physics_layer_collision_layer(1, 1)
		front_walls.tile_set.set_physics_layer_collision_mask(1, 2)
		for wall: Vector2i in front_walls.get_used_cells():
			var wall_data: TileData = front_walls.get_cell_tile_data(wall)
			wall_data.y_sort_origin = INSIDE_Y_SORT

func _on_room_area_body_exited(body: Node2D):
	if body.name == "Character":
		# Play the fade in animations for the walls and any doors.
		animation_player.play("front_walls_fade_in")
		# for child in front_walls.get_children():
		# 	if child is Door:
		# 		child.animation_player.play("door_fade_in")
		# Swaps between the two phyics layers and y-sort values for the bottom walls of a room.
		front_walls.tile_set.set_physics_layer_collision_layer(0, 1)
		front_walls.tile_set.set_physics_layer_collision_mask(0, 2)
		front_walls.tile_set.set_physics_layer_collision_layer(1, 0)
		front_walls.tile_set.set_physics_layer_collision_mask(1, 0)
		for wall: Vector2i in front_walls.get_used_cells():
			var wall_data: TileData = front_walls.get_cell_tile_data(wall)
			wall_data.y_sort_origin = OUTSIDE_Y_SORT
