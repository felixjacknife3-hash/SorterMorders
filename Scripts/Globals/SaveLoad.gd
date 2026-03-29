extends Node

var saveLoadRes = SaveLoad.new()

func _ready() -> void:
	saveLoadRes.loadFile()
	while true:
		await get_tree().create_timer(30).timeout
		saveLoadRes.saveFile()
