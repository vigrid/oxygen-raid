extends RigidBody2D

var LifeTime = 4.0
var Speed


func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	set_pos(get_pos() + Vector2(Speed, 0) * delta)
	var c = get_colliding_bodies()
	if c.size() > 0:
		queue_free()
	LifeTime -= delta
	if LifeTime < 0.0:
		queue_free()
