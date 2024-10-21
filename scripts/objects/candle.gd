class_name Candle
extends DefaultObject

func inspect() -> void:
	super.inspect()

	# toggle anim_sprite and sprite visibility
	anim_sprite.visible = !anim_sprite.visible
	sprite.visible = !sprite.visible