extends RigidBody2D

func hit():
	$Sprite2D.visible = false
	$CollisionShape2D.disabled = true
	$CPUParticles2D.emitting = true
	gm.score += 1
	
	await get_tree().create_timer(0.5).timeout
	get_parent().remove_child(self)
	queue_free()

