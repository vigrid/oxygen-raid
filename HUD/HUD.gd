extends CanvasLayer


var GameState
var ShipStatePath


func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	var level = 0
	var score = 0
	var lives = 0
	var fuel = 0.0
	
	if GameState != null:
		level = GameState.Level
		score = GameState.Score
		lives = GameState.Lives
	
	get_node("Level").set_text("Level: " + str(level))
	get_node("Score").set_text("Score: " + str(score))
	get_node("Lives").set_text("Lives: " + str(lives))
	
	if has_node(ShipStatePath):
		var shipState = get_node(ShipStatePath)
	
		if shipState != null:
			fuel = shipState.Fuel
	
	get_node("Fuel").set_value(fuel)

	var guy = get_node("DeadGuy")
	if get_node("/root/Game").Mode == "gameover":
		guy.show()
		var guyPos = guy.get_pos()
		guy.set_pos(Vector2(lerp(guyPos.x, 0.0, delta * 10.0), lerp(guyPos.y, 0.0, delta * 10.0)))
	else:
		guy.hide()
		guy.set_pos(Vector2(600,0))
	
	ProcessMessage(delta)


var MessageShowTime = 0.0
var MessageFadeTime = 0.0
var MessageFadeRate = 1.0


func Message(text, showTime, fadeTime):
	var messageNode = get_node("Message")
	messageNode.set_pos(Vector2(0, 344))
	messageNode.set_text(text)
	messageNode.set_opacity(1.0)
	MessageShowTime = showTime
	MessageFadeTime = fadeTime
	MessageFadeRate = 1.0 / fadeTime


func MessageLeft(text, showTime, fadeTime):
	Message(text, showTime, fadeTime)
	var messageNode = get_node("Message")
	messageNode.set_pos(Vector2(-200, 344))
	
	
func ProcessMessage(delta):
	var messageNode = get_node("Message")
	
	if MessageShowTime > 0.0:
		MessageShowTime -= delta
		messageNode.set_opacity(1.0)
	elif MessageFadeTime > 0.0:
		MessageFadeTime -= delta
		messageNode.set_opacity(messageNode.get_opacity() - MessageFadeRate * delta)
	else:
		messageNode.set_opacity(0.0)
