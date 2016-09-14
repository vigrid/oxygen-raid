extends Node


var Arena
var Mode = "starting"


var Score = 0
var Level = 0
var Lives = 0

var BonusIncrement = 5000
var NextBonus = 5000

var Timeout = 1

var GLOBAL


func _ready():
	set_fixed_process(true)


func _enter_tree():
	GLOBAL = get_node("/root/GLOBAL")


func _fixed_process(delta):
	if Arena != null:
		Arena.set_name("Arena")
	
	if Mode == "starting":
		Restart()
	
	elif Mode == "dead":
		Timeout -= delta
		if Timeout <= 0.0:
			get_node("HUD").Message("FIRE TO CONTINUE!", 3600.0, 3600.0)
			if Input.is_action_pressed("player_fire"):
				Start()
				Timeout = 1
	elif Mode == "gameover":
		Timeout -= delta
		if Timeout <= 0.0:
			if Input.is_action_pressed("player_fire"):
				GLOBAL.SetScreen("Menu")
	
	if Score >= NextBonus:
		NextBonus += BonusIncrement
		GLOBAL.SOUND_SYSTEM.LifeUp()
		get_node("HUD").Message("EXTRA LIFE!", 0.5, 0.5)
		Lives += 1


func KillPlayer():
	Lives -= 1
	if Lives > 0:
		Mode = "dead"
	else:
		Mode = "gameover"
		GLOBAL.SOUND_SYSTEM.GameOver()
		get_node("HUD").MessageLeft("GAME OVER", 3600.0, 3600.0)


func Start():
	if Arena != null:
		Arena.queue_free()

	Arena = Node2D.new()
	Arena.set_name("Arena")
	Arena.set_pos(Vector2(512, 0))
	add_child(Arena)
	
	get_node("/root/WORLD_GENERATOR").Initialize(Arena)
	get_node("/root/WORLD_GENERATOR").Start(Level)
	
	var player = get_node("/root/OBJECT_REPOSITORY").GetPlayer()
	player.set_pos(Vector2(512, 800))
	add_child(player)
	
	get_node("Camera2D").SetPlayerNodePath(player.get_path())
	
	get_node("HUD").GameState = self
	get_node("HUD").ShipStatePath = player.get_path()
	
	Mode = "started"


func Restart():
	Score = 0
	Level = 1
	Lives = 3
	
	Start()
