extends "res://Enemies/Enemy.gd"


func _ready():
	set_process(true)


func _process(delta):
	get_node("Sprite").set_flip_h(direction == 1)
	if get_pos().x < -800 || get_pos().x > 800:
		direction = -direction
