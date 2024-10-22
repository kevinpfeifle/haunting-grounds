class_name Door
extends StaticBody2D

## These values are expected to contain file extension as well (*.png)._apply_central_force
@export_category("Door Configurations")
@export var closed_door_sprite_name: String
@export var open_door_sprite_name: String
@export_enum("LEFT", "RIGHT") var direction: String = "LEFT"

var animation_player: AnimationPlayer
var click_area: Area2D
var collision_area: CollisionPolygon2D
var inversion_factor: int
var opened: bool = false
var sprite: Sprite2D
var sprite_closed: Texture2D
var sprite_opened: Texture2D

func _ready():
	animation_player = $AnimationPlayer
	click_area = $ClickArea
	collision_area = $CollisionArea
	sprite = $Sprite
	sprite_closed = load("res://assets/sprites/building/doors/" + closed_door_sprite_name)
	sprite_opened = load("res://assets/sprites/building/doors/" + open_door_sprite_name)

func _on_click_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if opened:
			opened = false
			sprite.texture = sprite_closed
			sprite.flip_h = false
			sprite.offset = Vector2(0, -200)
			sprite.position = Vector2(sprite.position.x, sprite.position.y + 150)
			click_area.scale.x = click_area.scale.x * -1
			collision_area.scale.x = collision_area.scale.x * -1
			collision_area.disabled = false
			if direction == "LEFT":
				pass
			else:
				position.x -= 180
				position.y += 5.05
		else:
			opened = true
			sprite.texture = sprite_opened
			sprite.flip_h = true
			sprite.offset = Vector2(0, -50)
			sprite.position = Vector2(sprite.position.x, sprite.position.y - 150)
			click_area.scale.x = click_area.scale.x * -1
			collision_area.scale.x = collision_area.scale.x * -1
			collision_area.disabled = true
			if direction == "LEFT":
				pass
			else:
				position.x += 180
				position.y -= 5.05

# origpos = -104, 309.8
# movedpos = 49, 329.8

# oldpos = -125, 572.472
# newpos = 229,554.426


# offset is 100,-175