class_name PlayerIdleState
extends PlayerState

func enter(args: Array) -> void:
	super(args)
	# Adds this back in once animations are ready.
	# if character.animation_player.current_animation != "idle":
	# 	character.animation_player.play("idle")

func physics_update(_delta):
	character.move_and_slide()
	if Input.is_action_pressed("player_left") or Input.is_action_pressed("player_right") or \
		Input.is_action_pressed("player_up") or Input.is_action_pressed("player_down"):
		transition.emit("Move", [])