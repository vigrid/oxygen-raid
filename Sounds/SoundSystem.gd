extends Node


var EffectsPlayer
var EnginePlayer
var FuelPlayer

var FuelVoice_Normal
var FuelVoice_Warning
var FuelVoice_Full
var EngineVoice


func _ready():
	EffectsPlayer = get_node("Effects")
	EnginePlayer = get_node("Engine")
	FuelPlayer = get_node("Fuel")
	
	get_node("/root/GLOBAL").SOUND_SYSTEM = self

	FixLoopingBecauseGodotIsShit(FuelPlayer, "fuel_collect")
	FixLoopingBecauseGodotIsShit(FuelPlayer, "fuel_warning")
	FixLoopingBecauseGodotIsShit(FuelPlayer, "fuel_full")
	FixLoopingBecauseGodotIsShit(EnginePlayer, "engine")
			
	if FuelVoice_Normal == null:
		FuelVoice_Normal = Play(FuelPlayer, "fuel_collect")
	if FuelVoice_Warning == null:
		FuelVoice_Warning = Play(FuelPlayer, "fuel_warning")
	if FuelVoice_Full == null:
		FuelVoice_Full = Play(FuelPlayer, "fuel_full")
	
	if EngineVoice == null:
		EngineVoice = Play(EnginePlayer, "engine")

	FuelPlayer.set_volume_db(FuelVoice_Normal, -80)
	FuelPlayer.set_volume_db(FuelVoice_Warning, -80)
	FuelPlayer.set_volume_db(FuelVoice_Full, -80)
	
	EnginePlayer.set_volume_db(EngineVoice, -80)
	
	set_fixed_process(true)


func _fixed_process(delta):
	if !has_node("/root/Game/Player"):
		Engine("silent")
		Fuel("silent")


func FixLoopingBecauseGodotIsShit(player, sampleName):
	var sample = player.get_sample_library().get_sample(sampleName)
	sample.set_loop_begin(0)
	sample.set_loop_end(sample.get_length())
	sample.set_loop_format(sample.LOOP_FORWARD)


func ShotPlayer():
	PlayRandomized(EffectsPlayer, "shot_player")


func ShotMiss():
	PlayRandomized(EffectsPlayer, "shot_miss")


func ShotEnemy():
	PlayRandomized(EffectsPlayer, "shot_enemy")


func ShotBoss():
	PlayRandomized(EffectsPlayer, "shot_boss")


func ExplosionPlayer():
	PlayRandomized(EffectsPlayer, "explosion_player")


func ExplosionEnemy():
	PlayRandomized(EffectsPlayer, "explosion_enemy")


func ExplosionBridge():
	PlayRandomized(EffectsPlayer, "explosion_bridge")


func ExplosionOxygen():
	PlayRandomized(EffectsPlayer, "explosion_oxygen")


func GameOver():
	Play(EffectsPlayer, "life_gameover")


func LifeUp():
	PlayRandomized(EffectsPlayer, "life_up")


var PreviousFuelMode = null


func Fuel(mode):
	if FuelVoice_Normal == null:
		FuelVoice_Normal = Play(FuelPlayer, "fuel_collect")
	if FuelVoice_Warning == null:
		FuelVoice_Warning = Play(FuelPlayer, "fuel_warning")
	if FuelVoice_Full == null:
		FuelVoice_Full = Play(FuelPlayer, "fuel_full")
	
	if mode == "normal":
		FuelPlayer.set_volume_db(FuelVoice_Normal, 0)
		FuelPlayer.set_volume_db(FuelVoice_Warning, -80)
		FuelPlayer.set_volume_db(FuelVoice_Full, -80)
	elif mode == "full":
		FuelPlayer.set_volume_db(FuelVoice_Normal, -80)
		FuelPlayer.set_volume_db(FuelVoice_Warning, -80)
		FuelPlayer.set_volume_db(FuelVoice_Full, 0)
	elif mode == "warning":
		FuelPlayer.set_volume_db(FuelVoice_Normal, -80)
		FuelPlayer.set_volume_db(FuelVoice_Warning, 0)
		FuelPlayer.set_volume_db(FuelVoice_Full, -80)
		if PreviousFuelMode != "warning":
			get_node("/root/Game/HUD").Message("O2 LOW!", 0.25, 0.25)
	else:
		FuelPlayer.set_volume_db(FuelVoice_Normal, -80)
		FuelPlayer.set_volume_db(FuelVoice_Warning, -80)
		FuelPlayer.set_volume_db(FuelVoice_Full, -80)
	
	PreviousFuelMode = mode


func Engine(mode):
	if mode == "fast":
		EnginePlayer.set_pitch_scale(EngineVoice, 1.41)
		EnginePlayer.set_volume_db(EngineVoice, 0)
	elif mode == "slow":
		EnginePlayer.set_pitch_scale(EngineVoice, 0.71)
		EnginePlayer.set_volume_db(EngineVoice, 0)
	elif mode == "silent":
		EnginePlayer.set_volume_db(EngineVoice, -80)
	else:
		EnginePlayer.set_pitch_scale(EngineVoice, 1.0)
		EnginePlayer.set_volume_db(EngineVoice, 0)
	

func Play(player, sample):
	return player.play(sample)


func PlayRandomized(player, sample):
	var voiceId = player.play(sample)
	player.set_pitch_scale(voiceId, randf() * 0.2 + 0.9)
	return voiceId
