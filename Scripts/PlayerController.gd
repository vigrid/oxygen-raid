extends Node


func _ready():
	set_process(true)


func _process(delta):
	set_pos(get_pos() + Vector2(0, -500) * delta)
