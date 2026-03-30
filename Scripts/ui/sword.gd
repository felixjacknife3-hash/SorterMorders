extends UpgradeButton

var sword: HurtBox
var res = saveLoad.saveLoadRes
var lvl: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	
	sword = get_tree().get_first_node_in_group("swordHurtBox")
	var level = res.loadKey("swordLevel")
	var dmg := 20
	if level is int:
		lvl = level
		for i in range(lvl):
			dmg += ceil(dmg ** 1.05) - dmg
	if sword:
		sword.damage = dmg
	
	

func press() -> void:
	super()
	sword.damage += ceil(sword.damage ** 1.05) - sword.damage
	res.data["swordLevel"] = lvl
