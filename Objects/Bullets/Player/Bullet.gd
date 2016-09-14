extends KinematicBody2D


var MaxDistance = 600
var Speed = 1200


var AccumulatedDistance = 0


func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	var distance = delta * Speed
	AccumulatedDistance += distance
	
	if AccumulatedDistance > MaxDistance:
		queue_free()
	else:
		move(Vector2(0, -distance))
		if is_colliding():
			var explosion = get_node("/root/OBJECT_REPOSITORY").GetTinyExplosion()
			var arena = get_node("/root/Game/Arena")
			arena.add_child(explosion)
			explosion.set_global_pos(get_global_pos())
			
			queue_free()
			var collider = get_collider()
			if collider.has_method("BulletHit"):
				collider.BulletHit(self)


func EnterFuel(fuel):
	get_node("/root/Game").Score += 170
	queue_free()
	fuel.queue_free()
	get_node("/root/GLOBAL").SOUND_SYSTEM.ExplosionOxygen()
	
	var explosion = get_node("/root/OBJECT_REPOSITORY").GetFuelExplosion()
	var arena = get_node("/root/Game/Arena")
	arena.add_child(explosion)
	explosion.set_global_pos(fuel.get_global_pos())
	explosion.get_node("AnimationPlayer").play("default")
