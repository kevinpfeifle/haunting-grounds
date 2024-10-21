class_name PlayerCamera
extends Camera2D

var player: Character
var player_last_pos: Vector2

var camera_position: Vector2
var mouse_position: Vector2
var camera_lock: bool = true
var dragging: bool = false

@onready var raycast = $RayCast2D

func _ready():
	raycast.enabled = true

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
			zoom += Vector2(0.25, 0.25)
	elif event.is_action_pressed("camera_zoom_out"):
		if zoom != Vector2(-1, -1):
			zoom += Vector2(-0.25, -0.25)
	elif event.is_action_pressed("center_camera"):
		position = player.position
	elif event.is_action_pressed("camera_lock"):
		camera_lock = !camera_lock

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		var mouse_pos = get_global_mouse_position()
		raycast.target_position = (mouse_pos - global_position).normalized() * 1000		
		raycast.force_raycast_update()
		
		if raycast.is_colliding():
			var collider = raycast.get_collider() 
			if collider is DefaultObject:
				collider.inspect()