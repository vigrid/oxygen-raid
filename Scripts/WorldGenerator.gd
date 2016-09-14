extends Node

var GLOBAL

var Arena
var LastSector
var CurrentLevel
var CurrentSegment


func _enter_tree():
	GLOBAL = get_node("/root/GLOBAL")


func Initialize(arena):
	randomize()
	
	Arena = arena


func Start(level):
	CurrentLevel = level
	CurrentSegment = 0
	
	LastSector = GLOBAL.SECTOR_REPOSITORY.GetStartSector()
	LastSector.SpawnChildren(GLOBAL.OBJECT_REPOSITORY, 0.0, 0.0, 0.0, 0.0)
	Arena.add_child(LastSector)
	CurrentSegment += 1


func S(level, levelOffset, multiplier, minFactor, maxFactor):
	return clamp((level + levelOffset) * multiplier, minFactor, maxFactor)


func Next(level):
	CurrentSegment += 1
	
	var enemyChance    = S(level,   0,    0.1,  0.2,  1.0)
	var fuelChance     = S(level, -11, -0.075, 0.35,  1.0)
	var movementChance = S(level,  -1,  0.125,  0.0, 0.75)
	var shootingChance = S(level,  -2,    0.1,  0.0,  1.0)
	
	var nextSector
	if CurrentSegment < level + 2:
		nextSector = GLOBAL.SECTOR_REPOSITORY.GetSector(LastSector.TopType, null, null)
	else:
		nextSector = GLOBAL.SECTOR_REPOSITORY.GetSectorToBridge(LastSector.TopType)
	
	if nextSector.TopType == "R" && nextSector.BottomType == "R":
		CurrentLevel += 1
		CurrentSegment = 0
	
	nextSector.set_pos(LastSector.GetTopCenter() + Vector2(0, -nextSector.Height / 2))
	Arena.add_child(nextSector)
	nextSector.SpawnChildren(GLOBAL.OBJECT_REPOSITORY, enemyChance, fuelChance, movementChance, shootingChance)
	LastSector = nextSector
