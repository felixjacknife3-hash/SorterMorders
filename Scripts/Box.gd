extends Node3D

@export var itemArray: Array[PackedScene]
@export var chancesArray: Array[int]
@export var spawnPoint: Marker3D

var treeParent: Node3D
var plr: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.treeParent = get_parent_node_3d()
	if get_tree().get_first_node_in_group("player"):
		plr = get_tree().get_first_node_in_group("player")

# Randomization Region
#region
func getTotalChances() -> int:
	var total: int = 0
	for num in chancesArray:
		total += num
	return total

func getTotalFromIndex(idx: int) -> int:
	var total: int = 0
	for i in range(idx):
		total += chancesArray[i]
	return total

func getRandItem() -> PackedScene:
	var rand = RandomNumberGenerator.new()
	var totalChances = getTotalChances()
	var randNum = rand.randi_range(0, totalChances)
	
	for i in range(len(chancesArray)):
		if randNum >= getTotalFromIndex(i):
			return itemArray[i]
	return null

func getRandPopOut(
	baseY: float, 
	yRange: float, 
	xRange: float, 
	zRange: float) -> Vector3:
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	var randXOffset = rand.randf_range(-xRange, xRange)
	rand.randomize()
	var randZOffset = rand.randf_range(-zRange, zRange)
	rand.randomize()
	var randYOffset = rand.randf_range(-yRange, yRange)
	
	var vec3 = Vector3(randXOffset, 
	baseY + randYOffset, 
	randZOffset)
	return vec3
#endregion

# Take Money
#region
func sell(amount: int) -> bool:
	if not plr: return false
	return plr.money.subtractMoney(amount)

func buyBox() -> void:
	var randItem: PackedScene = getRandItem()
	var instance = randItem.instantiate()
	if instance is SellableDraggableBody:
		var rand = RandomNumberGenerator.new()
		rand.randomize()
		var price = rand.randi_range(2, 6)
		if plr.money.money < price: return
		
		if !sell(price):
			return
		
		var linearForce = getRandPopOut(8, 1, 1.5, 1.5)
		var angularForce = getRandPopOut(0, 1, 1, 1)
		instance.linear_velocity = linearForce * 2
		instance.angular_velocity = angularForce * 1.2
		treeParent.add_child(instance)
		instance.global_position = spawnPoint.global_position
		
	else:
		instance.queue_free()
#endregion

func interacted():
	buyBox()
