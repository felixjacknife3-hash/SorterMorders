extends Node

var timeWait: float = 2.5
var t: float = 0.0


signal sendInfo(text: String)

func sendPlayerInfo(text: String):
	t = 0
	sendInfo.emit(text)
	await get_tree().create_timer(timeWait).timeout
	if t >= timeWait:
		sendInfo.emit("")

func _process(delta: float) -> void:
	t += delta
