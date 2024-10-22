class_name Candle
extends DefaultObject

func inspect() -> void:
	super.inspect()

	# toggle anim_sprite and sprite visibility
	if (not is_destroyed):
		turn_off()

func turn_off() -> void:
	anim_sprite.visible = !anim_sprite.visible
	sprite.visible = !sprite.visible

	super.destroy()