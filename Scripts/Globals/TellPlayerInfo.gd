extends Node

signal sendInfo(text: String)

func sendPlayerInfo(text: String):
	sendInfo.emit(text)
