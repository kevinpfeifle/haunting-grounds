class_name PlayerMoveState
extends PlayerState

func enter(args: Array) -> void:
	super(args)
	# Adds this back in once animations are ready.
	# if character.animation_player.current_animation != "move":
	# 	character.animation_player.play("move")

func physics_update(_delta):
	var input_x: float = Input.get_axis("player_left", "player_right")
	var input_y: float = Input.get_axis("player_up", "player_down")

	character.velocity.x = input_x * character.SPEED
	character.velocity.y = input_y * character.SPEED
	
	if character.velocity.x < 0:
		character.sprite.position.x = -1
	else:
		character.sprite.position.x = 1

	character.move_and_slide()

	if character.velocity == Vector2(0, 0):
		transition.emit("idle", [])