extends Node2D


var LifeTime = 1.0


func _ready():
	set_fixed_process(true)
	get_node("/root/GLOBAL").SOUND_SYSTEM.ShotMiss()


func _fixed_process(delta):
	LifeTime -= delta
	if LifeTime < 0.0:
		queue_free()
