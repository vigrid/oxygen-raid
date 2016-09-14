extends Node


var Enemies = {
	"Copter": load("res://Enemies/Copter/Copter.xscn"),
	"CopterWide": load("res://Enemies/CopterWide/CopterWide.xscn"),
	"Balloon": load("res://Enemies/Balloon/Balloon.xscn")
}


var Explosions = {
	"E1": load("res://Objects/Explosions/Explosion_01.xscn")
}


func GetRandom(dictionary):
	var keys = dictionary.keys()
	return dictionary[keys[randi() % keys.size()]].instance()


func GetPlayer():
	return load("res://Player/Player.xscn").instance()


func GetEnemy():
	return GetRandom(Enemies)


func GetFlyingEnemy():
	return load("res://Enemies/Jet/Jet.xscn").instance()


func GetFuel():
	return load("res://Objects/Fuel/Fuel.xscn").instance()


func GetPlayerBullet():
	return load("res://Objects/Bullets/Player/Bullet.xscn").instance()


func GetEnemyBullet():
	return load("res://Objects/Bullets/Enemy/EnemyShoot.xscn").instance()


func GetBossBullet():
	return load("res://Objects/Bullets/Enemy/BossShoot.xscn").instance()


func GetExplosion():
	return GetRandom(Explosions)


func GetTinyExplosion():
	return load("res://Objects/Explosions/TinyFromRocks.xscn").instance()


func GetFuelExplosion():
	return load("res://Objects/Explosions/Fuel.xscn").instance()
