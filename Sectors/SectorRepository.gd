extends Node


var SectorCache = {
	"Sec_BB_01": load("res://Sectors/Sec_BB_01.xscn"),
	"Sec_BB_02": load("res://Sectors/Sec_BB_02.xscn"),
	"Sec_BB_03": load("res://Sectors/Sec_BB_03.xscn"),
	"Sec_BB_04": load("res://Sectors/Sec_BB_04.xscn"),
	"Sec_BE_01": load("res://Sectors/Sec_BE_01.xscn"),
	"Sec_BI_01": load("res://Sectors/Sec_BI_01.xscn"),
	"Sec_BM_01": load("res://Sectors/Sec_BM_01.xscn"),
	"Sec_BM_02": load("res://Sectors/Sec_BM_02.xscn"),
	"Sec_BS_01": load("res://Sectors/Sec_BS_01.xscn"),
	"Sec_BS_02": load("res://Sectors/Sec_BS_02.xscn"),
	"Sec_IB_01": load("res://Sectors/Sec_IB_01.xscn"),
	"Sec_II_01": load("res://Sectors/Sec_II_01.xscn"),
	"Sec_II_02": load("res://Sectors/Sec_II_02.xscn"),
	"Sec_II_03": load("res://Sectors/Sec_II_03.xscn"),
	"Sec_II_04": load("res://Sectors/Sec_II_04.xscn"),
	"Sec_IM_01": load("res://Sectors/Sec_IM_01.xscn"),
	"Sec_IS_01": load("res://Sectors/Sec_IS_01.xscn"),
	"Sec_MB_01": load("res://Sectors/Sec_MB_01.xscn"),
	"Sec_MB_02": load("res://Sectors/Sec_MB_02.xscn"),
	"Sec_MI_01": load("res://Sectors/Sec_MI_01.xscn"),
	"Sec_MM_01": load("res://Sectors/Sec_MM_01.xscn"),
	"Sec_MM_02": load("res://Sectors/Sec_MM_02.xscn"),
	"Sec_MM_03": load("res://Sectors/Sec_MM_03.xscn"),
	"Sec_MM_04": load("res://Sectors/Sec_MM_04.xscn"),
	"Sec_MS_01": load("res://Sectors/Sec_MS_01.xscn"),
	"Sec_MS_02": load("res://Sectors/Sec_MS_02.xscn"),
	"Sec_RR_01": load("res://Sectors/Sec_RR_01.xscn"),
	"Sec_SB_01": load("res://Sectors/Sec_SB_01.xscn"),
	"Sec_SB_02": load("res://Sectors/Sec_SB_02.xscn"),
	"Sec_SI_01": load("res://Sectors/Sec_SI_01.xscn"),
	"Sec_SM_01": load("res://Sectors/Sec_SM_01.xscn"),
	"Sec_SM_02": load("res://Sectors/Sec_SM_02.xscn"),
	"Sec_SS_01": load("res://Sectors/Sec_SS_01.xscn"),
	"Sec_SS_02": load("res://Sectors/Sec_SS_02.xscn"),
	"Sec_SS_03": load("res://Sectors/Sec_SS_03.xscn"),
	"Sec_SS_04": load("res://Sectors/Sec_SS_04.xscn")
}


func GetStartSector():
	return GetSector("E", "B", null )


func GetSectorWithPreference(bottomType, topTypes):
	for topType in topTypes:
		var candidate = GetSector(bottomType, topType, null)
		if candidate != null:
			return candidate


func GetSectorToBridge(bottomType):
	var candidate
	
	if bottomType == "S":
		candidate = GetSector("R", "R", null)
	else:
		candidate = GetSectorWithPreference(bottomType, ["S", "M", "B"])
	
	return candidate


func GetSector(bottomType, topType, hint):
	var candidates = []
	
	if bottomType == "R" && topType != "R":
		bottomType = "S"
	
	for key in SectorCache.keys():
		var top = key[4]
		var btm = key[5]
		var hnt = key.substr(7, 2)
		
		if (bottomType == null || btm == bottomType) && (topType == null || top == topType) && (hint == null || hnt == hint):
			candidates.append(key)
	
	return GetRandom(candidates)


func GetRandom(candidates):
	var size = candidates.size()
	if size == 0:
		return null

	var candidateKey = candidates[randi() % size]

	var copy = SectorCache[candidateKey].instance()
	copy.TopType = candidateKey[4]
	copy.BottomType = candidateKey[5]
	copy.Hint = candidateKey.substr(7, 2)
	
	return copy
