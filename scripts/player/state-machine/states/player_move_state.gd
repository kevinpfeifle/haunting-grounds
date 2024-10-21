class_name PlayerMoveState
extends PlayerState

var player_scale: Vector2
var player_scale_inv: Vector2

func enter(args: Array) -> void:
	super(args)
	# Adds this back in once animations are ready.
	if character.animation_player.current_animation != "move":
		character.animation_player.play("move")
	player_scale = abs(character.sprite.scale)
	player_scale_inv = player_scale * -1


func physics_update(_delta):
	var input_x: float = Input.get_axis("player_left", "player_right")
	var input_y: float = Input.get_axis("player_up", "player_down")

	character.velocity.x = input_x * character.SPEED
	character.velocity.y = input_y * character.SPEED
	
	if character.velocity.x < 0:
		character.sprite.scale.x = player_scale.x
	elif character.velocity.x > 0:
		character.sprite.scale.x = player_scale_inv.x

	character.move_and_slide()

	if character.velocity == Vector2(0, 0):
		transition.emit("idle", [])