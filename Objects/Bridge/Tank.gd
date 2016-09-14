extends Sprite


var ShootingEnabled = false
var ShootingTimeout = 0.1
var Direction = 0


func _ready():
	set_fixed_process(true)


func EnableShooting():
	ShootingEnabled = true


func _fixed_process(delta):
	if ShootingEnabled:
		ShootingTimeout -= delta
		if ShootingTimeout < 0.0:
			ShootingTimeout = 0.2 + 4.0 / (get_node("/root/Game").Level + 5)
			Shoot()


func Shoot():
	var bullet = get_node("/root/OBJECT_REPOSITORY").GetBossBullet()
	get_node("/root/GLOBAL").SOUND_SYSTEM.ShotBoss()
	bullet.Speed = Direction * 600
	bullet.set_pos(get_pos() + Vector2(115, 0) * Direction)
	get_parent().add_child(bullet)