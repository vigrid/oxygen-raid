extends Node


var WORLD_GENERATOR
var SOUND_SYSTEM
var SECTOR_REPOSITORY
var OBJECT_REPOSITORY

var FullScreen = true


var CurrentScene = null


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	WORLD_GENERATOR = get_node("/root/WORLD_GENERATOR")
	SECTOR_REPOSITORY = get_node("/root/SECTOR_REPOSITORY")
	OBJECT_REPOSITORY = get_node("/root/OBJECT_REPOSITORY")
	
	CurrentScene = GetCurrentScene()
	
	set_process_input(true)


func SetScreen(screen):
	SetScene("res://Screens/" + screen + ".xscn")


func _input(event):
	if event.is_pressed() && !event.is_echo():
		if event.is_action("ui_togglefullscreen"):
			FullScreen = !FullScreen
			OS.set_window_fullscreen(FullScreen)
		if event.is_action("ui_cancel"):
			SetScreen("Menu")


func Exit():
	get_tree().quit()


func SetScene(scene):
	CurrentScene.queue_free()
	var newScene = ResourceLoader.load(scene)
	CurrentScene = newScene.instance()
	GetRoot().add_child(CurrentScene)


func GetRoot():
	return get_tree().get_root()


func GetCurrentScene():
	var root = GetRoot()
	return root.get_child(root.get_child_count() - 1)
