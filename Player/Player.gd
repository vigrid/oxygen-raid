extends RigidBody2D


export var HorizontalSpeed = 300
export var VerticalSpeed = 300
export var FastMultiplier = 2.50
export var SlowMultiplier = 0.4
export var RefuelRate = 0.25
export var FuelConsumptionRate = 0.05


var Speed = "fast"
var Refueling = 0
var Fuel = 1.0
var ControlsKnown = false
var ControlsEnabled = null
var WasFirePressed = false


func EnterFuel(fuel):
	Refueling += 1


func ExitFuel(fuel):
	Refueling -= 1


func _ready():
	set_fixed_process(true)


func EnableControls(enabled):
	var hud = get_node("/root/Game/HUD")
	
	if enabled:
		if !ControlsKnown || !ControlsEnabled:
			hud.Message("FIGHT!", 0.5, 0.5)
	else:
		if !ControlsKnown || ControlsEnabled:
			hud.Message("GET READY!", 1.0, 0.5)
	
	ControlsKnown = true
	ControlsEnabled = enabled


func _fixed_process(delta):
	EnableControls(get_pos().y < 256)

	HandleCollisions(delta)
	HandleSpeed(delta)
	HandleMovement(delta)
	HandleShooting(delta)
	
	if ControlsEnabled:
		if Refueling > 0:
			Fuel += delta * RefuelRate
		else:
			Fuel -= delta * FuelConsumptionRate
	
	if Fuel < 0.0:
		Die()
	if Fuel >= 1:
		Fuel = 1.0

	var fuelMode = "silent"
	if Refueling > 0:
		if Fuel >= 1.0:
			fuelMode = "full"
		else:
			fuelMode = "normal"
	elif Fuel < 0.25:
		fuelMode = "warning"
		
	get_node("/root/GLOBAL").SOUND_SYSTEM.Fuel(fuelMode)
	get_node("/root/GLOBAL").SOUND_SYSTEM.Engine(Speed)


func Die():
	get_node("/root/GLOBAL").SOUND_SYSTEM.ExplosionPlayer()
	var explosion = get_node("/root/OBJECT_REPOSITORY").GetExplosion()
	explosion.set_pos(get_pos())
	explosion.get_node("AnimationPlayer").play("default")
	get_parent().add_child(explosion)
	get_node("/root/Game").KillPlayer()
	get_node("/root/Game/Camera2D").Shake(40.0, 40.0, 0.5)
	queue_free()


func HandleCollisions(delta):
	var c = get_colliding_bodies()
	if c.size() > 0:
		Die()


func HandleSpeed(delta):
	if ControlsEnabled && Input.is_action_pressed("player_up"):
		Speed = "fast"
	elif ControlsEnabled && Input.is_action_pressed("player_down"):
		Speed = "slow"
	else:
		Speed = "normal"

	if (Speed == "fast"):
		get_node("Extras_Fast").show()
	else:
		get_node("Extras_Fast").hide()

	if (Speed == "normal"):
		get_node("Extras_Normal").show()
	else:
		get_node("Extras_Normal").hide()

	if (Speed == "slow"):
		get_node("Extras_Slow").show()
	else:
		get_node("Extras_Slow").hide()


var LastDX = 0.0
var LastMult = 1.0


func HandleMovement(delta):
	var dx = 0
	var dy = 1
	
	if ControlsEnabled && Input.is_action_pressed("player_left"):
		dx = lerp(LastDX, -1.0, delta * 10.0)
	elif ControlsEnabled && Input.is_action_pressed("player_right"):
		dx = lerp(LastDX, 1.0, delta * 10.0)
	else:
		dx = lerp(LastDX, 0.0, delta * 10.0)
	
	var num = (dx * 2.0) + 2.5
	get_node("Ship").set_frame(num)
	
	var multiplier = 1
	
	if Speed == "fast":
		multiplier = lerp(LastMult, FastMultiplier, delta * 2.0)
	elif Speed == "slow":
		multiplier = lerp(LastMult, SlowMultiplier, delta * 8.0)
	else:
		multiplier = lerp(LastMult, 1.0, delta * 6.0)
			
	set_pos(get_pos() + Vector2(HorizontalSpeed * dx, - VerticalSpeed * multiplier * dy) * delta)
	
	LastDX = dx
	LastMult = multiplier


var PressedTimeout = 0.2

func HandleShooting(delta):
	if !ControlsEnabled:
		return
	
	if !Input.is_action_pressed("player_fire") || PressedTimeout < 0.0:
		WasFirePressed = false
		PressedTimeout = 0.2
		return
	
	PressedTimeout -= delta
	
	if !WasFirePressed:
		WasFirePressed = true
		if !has_node("bullet"):
			var bullet = get_node("/root/OBJECT_REPOSITORY").GetPlayerBullet()
			bullet.set_name("bullet")
			bullet.set_pos(Vector2(0, -50))
			bullet.show()
			add_child(bullet)
			get_node("/root/GLOBAL").SOUND_SYSTEM.ShotPlayer()
