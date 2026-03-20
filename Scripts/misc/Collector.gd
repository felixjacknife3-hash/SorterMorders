extends Area3D
class_name Collector

var currBody: SellableDraggableBody

func areaEntered(body) -> void:
	if !(body is SellableDraggableBody): return
	currBody = body
	var plr = getPlayer()
	if not plr: return
	while currBody:
		if not currBody.held:
			plr.money.addMoney(currBody.price)
			await get_tree().create_timer(0.2).timeout
			if currBody:
				currBody.queue_free()
		await get_tree().create_timer(0.1).timeout

func areaLeft(_body):
	currBody = null

func getPlayer() -> Player:
	if not get_tree().get_first_node_in_group("player"): return null
	var plr = get_tree().get_first_node_in_group("player")
	return plr
