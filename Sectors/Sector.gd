extends RigidBody2D

export var Height = 768

var TopType
var BottomType
var Hint


var NextSector = null
var PrevSector = null


func _enter_tree():
	var vn = VisibilityNotifier2D.new()
	vn.set_rect(Rect2(-512, -Height / 2, 1024, Height))
	vn.connect("enter_screen", self, "OnEnterScreen")
	vn.connect("exit_screen", self, "OnExitScreen")
	add_child(vn)


func GetTopCenter():
	return get_pos() + Vector2(0, -Height / 2)


func SpawnChildren(objectRepository, enemyChance, fuelChance, movementChance, shootingChance):
	if !has_node("Spawners"):
		return
	
	var spawnerContainer = get_node("Spawners")
	
	if spawnerContainer != null:
		var spawners = spawnerContainer.get_children()
		
		for spawner in spawners:
			var spawned = null
			if spawner.SpawnerType == "Enemy":
				if randf() < enemyChance:
					var flying = randf() < (shootingChance / 3.0)
					if flying:
						spawned = objectRepository.GetFlyingEnemy()
					else:
						spawned = objectRepository.GetEnemy()
					
					spawned.set_pos(spawner.get_pos())
					spawned.show()
					
					spawned.Speed = (get_node("/root/Game").Level * 20.0) * randf() + 80.0
					if flying:
						spawned.Speed *= 4.0
						spawned.EnableMovement(true)
					else:
						spawned.EnableShooting(randf() < shootingChance)
						spawned.EnableMovement(randf() < movementChance)
					
					add_child(spawned)
			elif spawner.SpawnerType == "Fuel":
				if randf() < fuelChance:
					spawned = objectRepository.GetFuel()
					spawned.set_pos(spawner.get_pos())
					spawned.show()
					add_child(spawned)
	
	remove_child(spawnerContainer)


func OnEnterScreen():
	get_node("/root/WORLD_GENERATOR").Next(get_node("../..").Level)


func OnExitScreen():
	queue_free()
