extends Node


var GLOBAL


func _ready():
	GLOBAL = get_node("/root/GLOBAL")
	
	set_process_input(true)
	var player = get_node("AnimationPlayer")
	player.set_active(true)
	player.play("default")


func _input(event):
	if event.is_pressed():
		if event.is_action_pressed("ui_cancel"):
			GLOBAL.SetScreen("Menu")
