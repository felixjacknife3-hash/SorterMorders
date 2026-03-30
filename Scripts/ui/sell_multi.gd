extends UpgradeButton

var res = saveLoad.saveLoadRes
var level: int = 1
var currMulti: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	var lvl = res.loadKey("sellLevel")
	if lvl is int:
		level = lvl
		for i in range(level):
			currMulti += ceil(currMulti ** 0.8) - currMulti
			cost = ceil(cost ** power)
	UpgradeManager.sellMulti = currMulti

func press() -> void:
	super()
	level += 1
	res.data["sellLevel"] = level
	UpgradeManager.addSellMulti(ceil(UpgradeManager.sellMulti ** 0.8) - UpgradeManager.sellMulti)
