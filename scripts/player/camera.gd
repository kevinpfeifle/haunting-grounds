class_name PlayerCamera
extends Camera2D

@export_range(0.0, 1.0) var zoom_speed: float = 0.25

var player: Character
var player_last_pos: Vector2

var camera_position: Vector2
var mouse_position: Vector2
var camera_lock: bool = true
var dragging: bool = false

func _process(_delta):
	if camera_lock and (player_last_pos != player.position):
		position = player.position
		player_last_pos = player.position

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
	elif event.is_action_pressed("camera_zoom_in"):
		if zoom != Vector2(4, 4):
			zoom += Vector2(zoom_speed, zoom_speed)
	elif event.is_action_pressed("camera_zoom_out"):
		if zoom != Vector2(-1, -1):
			zoom += Vector2(-zoom_speed, -zoom_speed)
	elif event.is_action_pressed("center_camera"):
		position = player.position
	elif event.is_action_pressed("camera_lock"):
		camera_lock = !camera_lock