class_name PlayerCamera
extends Camera2D

@export_range(0.0, 1.0) var zoom_speed: float = 0.25
@export_range(0, 10) var max_zoom: int = 5
@export_range(100, 1000) var camera_speed: int = 400

var player: Character
var player_last_pos: Vector2

var camera_position: Vector2
var mouse_position: Vector2
var camera_lock: bool = true
var dragging: bool = false

func _process(delta):
	if camera_lock and (player_last_pos != player.position):
		position = player.position
		player_last_pos = player.position
	if Input.is_action_pressed("camera_move_left"):
		position -= Vector2(camera_speed / zoom.x, 0) * delta
	if Input.is_action_pressed("camera_move_right"):
		position += Vector2(camera_speed / zoom.x, 0) * delta
	if Input.is_action_pressed("camera_move_up"):
		position -= Vector2(0, camera_speed / zoom.y) * delta
	if Input.is_action_pressed("camera_move_down"):
		position += Vector2(0, camera_speed / zoom.y) * delta

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
		if zoom != Vector2(max_zoom, max_zoom):
			zoom += Vector2(zoom_speed, zoom_speed)
	elif event.is_action_pressed("camera_zoom_out"):
		if zoom != Vector2(1, 1):
			zoom += Vector2(-zoom_speed, -zoom_speed)
	elif event.is_action_pressed("center_camera"):
		position = player.position
	elif event.is_action_pressed("camera_lock"):
		camera_lock = !camera_lock