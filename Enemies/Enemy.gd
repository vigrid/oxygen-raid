extends RigidBody2D


export var ShootRadius = 50


var Speed = 100
export var Score = 100


var direction = 1
var collisionEnabled = true


var MovementEnabled = false
var ShootingEnabled = false
var ShootingTimeout = 2.0


func _ready():
	if randf() < 0.5:
		direction = 1
	else:
		direction = -1
	
	ShootingTimeout *= randf()

	set_fixed_process(true)


func EnableMovement(enable):
	MovementEnabled = enable


func EnableShooting(enable):
	ShootingEnabled = enable


func _fixed_process(delta):
	if MovementEnabled:
		set_pos(get_pos() + Vector2(direction, 0) * Speed * delta)

	if collisionEnabled:
		var c = get_colliding_bodies()
		if c.size() > 0:
			direction = -direction
			set_pos(get_pos() + Vector2(direction, 0) * Speed * delta * 3)
			collisionEnabled = false
	else:
		collisionEnabled = true
	
	if ShootingEnabled:
		ShootingTimeout -= delta
		if ShootingTimeout <= 0.0:
			ShootingTimeout = 2.0
			Shoot()


func Shoot():
	var bullet = get_node("/root/OBJECT_REPOSITORY").GetEnemyBullet()
	bullet.Speed = direction * 400
	get_parent().add_child(bullet)
	bullet.set_global_pos(get_global_pos() + Vector2(ShootRadius, 0) * direction)
	get_node("/root/GLOBAL").SOUND_SYSTEM.ShotEnemy()
	


func BulletHit(bullet):
	get_node("/root/Game").Score += Score
	queue_free()
	get_node("/root/GLOBAL").SOUND_SYSTEM.ExplosionEnemy()
	
	var explosion = get_node("/root/OBJECT_REPOSITORY").GetExplosion()
	get_parent().add_child(explosion)
	explosion.set_pos(get_pos())
	explosion.get_node("AnimationPlayer").play("default")
