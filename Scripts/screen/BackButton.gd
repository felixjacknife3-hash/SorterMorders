extends ComputerNormalButton

@export var screen: Screen

var plr: Player
var cam: Camera3D

func _ready() -> void:
	buildColRegion()
	# code
	if get_tree().get_first_node_in_group("player"):
		plr = get_tree().get_first_node_in_group("player")
		cam = plr.cam

func press():
	screen.changeViewing()
	cam.current = true
	print("game button")
