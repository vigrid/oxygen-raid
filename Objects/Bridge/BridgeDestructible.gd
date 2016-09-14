extends RigidBody2D


func BulletHit(bullet):
	get_node("../Static").set_owner(get_parent())
	
	get_node("../Destroyed").set_owner(get_parent())
	get_node("../Destroyed").show()
	
	get_node("../Destructible").queue_free()
	
	for i in range(8):
		var explosion = get_node("/root/OBJECT_REPOSITORY").GetExplosion()
		get_parent().add_child(explosion)
		explosion.set_pos(get_pos() + Vector2((randf() - 0.5) * 200.0, (randf() - 0.5) * 50.0))
		explosion.get_node("AnimationPlayer").play("default")
	
	get_node("/root/GLOBAL").SOUND_SYSTEM.ExplosionBridge()
	
	get_parent().TankSpeed = 0
	
	if abs(get_parent().TankPosition) < 250:
		for i in range(8):
			var explosion = get_node("/root/OBJECT_REPOSITORY").GetExplosion()
			get_parent().add_child(explosion)
			explosion.set_pos(get_node("../Tank").get_pos() + Vector2((randf() - 0.5) * 200.0, (randf() - 0.5) * 50.0))
			explosion.get_node("AnimationPlayer").play("default")
			get_node("/root/GLOBAL").SOUND_SYSTEM.ExplosionBridge()
			
		get_node("../Tank").queue_free()
		get_parent().TankDestroyed = true
		get_node("/root/Game").Score += 500
	
	get_node("../Tank").EnableShooting()

	get_node("/root/Game").Level += 1
	get_node("/root/Game").Score += 250

	get_node("/root/Game/Camera2D").Shake(40.0, 40.0, 0.15)
