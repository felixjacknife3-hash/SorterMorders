extends Node

signal sendInfo(text: String)

func sendPlayerInfo(text: String):
	sendInfo.emit(text)
	await get_tree().create_timer(2.5).timeout
	sendInfo.emit("")
