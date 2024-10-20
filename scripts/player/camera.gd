class_name PlayerCamera
extends Camera2D

var player: Character

var camera_position: Vector2
var mouse_position: Vector2
var dragging: bool = false

func _input(event):
	if event.is_action("camera_drag"):
		if event.is_pressed():
			dragging = true
			mouse_position = event.position
			camera_position = position
		else:
			dragging = false
	elif event is InputEventMouseMotion and dragging:
		position = ((mouse_position - event.position) / zoom) + camera_position
	elif event.is_action("center_camera"):
		position = player.position
	elif event.is_action("camera_zoom_in"):
		if zoom != Vector2(4, 4):
			zoom += Vector2(0.25, 0.25)
	elif event.is_action("camera_zoom_out"):
		if zoom != Vector2(1, 1):
			zoom += Vector2(-0.25, -0.25)