extends Area3D
class_name Collector

func areaEntered(body):
	if body is SellableDraggableBody:
		var plr = getPlayer()
		if not plr: return
		

func getPlayer() -> Player:
	if not get_tree().get_first_node_in_group("player"): return null
	var plr = get_tree().get_first_node_in_group("player")
	return plr
	
