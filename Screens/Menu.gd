extends Node


var Option = 0


var GLOBAL


func _enter_tree():
	GLOBAL = get_node("/root/GLOBAL")


func _ready():
	set_fixed_process(true)
	set_process_input(true)
	
	var player = get_node("AnimationPlayer")
	player.set_active(true)
	player.play("default")


func _fixed_process(delta):
	get_node("Options/Selection/Selector").set_pos(Vector2(0, Option * 80))


func _input(event):
	if event.is_pressed()  && !event.is_echo():
		if event.is_action("ui_up"):
			ChangeOption(-1)
		if event.is_action("ui_down"):
			ChangeOption(1)
		if event.is_action("ui_accept"):
			AcceptOption()


func ChangeOption(delta):
	Option = (Option + delta + 3) % 3


func AcceptOption():
	if Option == 0:
		GLOBAL.SetScreen("Game")
	if Option == 1:
		GLOBAL.SetScreen("Credits")
	if Option == 2:
		GLOBAL.Exit()
