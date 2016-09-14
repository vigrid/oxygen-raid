extends Node2D


var TankPosition = 0
var TankSpeed
var TankDestroyed


func _ready():
	if randf() < 0.5:
		get_node("Tank").Direction = -1
	else:
		get_node("Tank").Direction = 1
	
	TankPosition = get_node("Tank").Direction * (-(512 + randf() * 200))
	TankSpeed = get_node("Tank").Direction * (85 + (randf() - 0.5) * 30 - 15)

	set_fixed_process(true)


func _fixed_process(delta):
	if !TankDestroyed:
		TankPosition += delta * TankSpeed
		get_node("Tank").set_pos(Vector2(TankPosition, 0))
