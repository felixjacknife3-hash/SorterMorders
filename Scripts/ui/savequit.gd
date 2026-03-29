extends Button

var res = saveLoad.saveLoadRes

func _pressed() -> void:
	res.saveFile()
	get_tree().quit()
