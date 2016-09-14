extends Node2D


func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	if !get_node("AnimationPlayer").is_playing():
		queue_free()
