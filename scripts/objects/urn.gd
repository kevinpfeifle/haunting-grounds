class_name Urn
extends DefaultObject

func inspect():
	if not is_destroyed:
		var ashes_instance = $AshParticles
		var gpu_particles = ashes_instance.get_node("GPUParticles2D")
		gpu_particles.emitting = true

		super.inspect()

func interact():
	super.interact()
	destroy()

func destroy():
	if not is_destroyed:
		sprite.flip_v = true
		super.destroy()