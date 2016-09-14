extends Camera2D


var PlayerNodePath


func _ready():
	set_fixed_process(true)


func SetPlayerNodePath(path):
	PlayerNodePath = path


func _fixed_process(delta):
	if has_node(PlayerNodePath):
		var player = get_node(PlayerNodePath)

		if player != null:
			set_pos(player.get_pos() + Vector2(0, -270))

	ShakeDurationRemaining -= delta
	if ShakeDurationRemaining < 0.0:
		ShakeDurationRemaining = 0.0
	
	var offset = Vector2(0.0, 0.0)
	
	if ShakeDurationRemaining > 0.0:
		offset = Vector2((randf() - 0.5) * ShakeSizeX, (randf() - 0.5) * ShakeSizeY) * ShakeDurationRemaining / ShakeDuration

	set_offset(offset)


var ShakeSizeX = 0.0
var ShakeSizeY = 0.0
var ShakeDuration = 0.0
var ShakeDurationRemaining = 0.0


func Shake(sizeX, sizeY, duration):
	ShakeSizeX = sizeX
	ShakeSizeY = sizeY
	ShakeDuration = duration
	ShakeDurationRemaining = duration
