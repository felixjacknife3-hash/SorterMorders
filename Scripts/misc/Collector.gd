extends Area3D
class_name Collector

var currBody: SellableDraggableBody

func areaEntered(body):
	if body is SellableDraggableBody:
		var plr = getPlayer()
		if not plr: return
		while body:
			if not body.held:
				plr.money.addMoney(body.price)
				await get_tree().create_timer(0.2).timeout
				if body:
					body.queue_free()
			await get_tree().create_timer(0.1).timeout

func areaLeft(_body):
	currBody = null

func getPlayer() -> Player:
	if not get_tree().get_first_node_in_group("player"): return null
	var plr = get_tree().get_first_node_in_group("player")
	return plr
