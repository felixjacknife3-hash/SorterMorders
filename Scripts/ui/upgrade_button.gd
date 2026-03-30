extends ComputerNormalButton
class_name UpgradeButton

var plr: Player

@export var cost: int = 100
@export var power: float = 1.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buildColRegion()
	plr = get_tree().get_first_node_in_group("player")

#called when the button is pressed
func press() -> void:
	if !plr: return
	if !plr.money.subtractMoney(cost): return
	cost = ceil(cost ** power)

func _process(_delta: float) -> void:
	text = name + " - " + str(cost) 
