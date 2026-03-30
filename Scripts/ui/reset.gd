extends Button

var res = saveLoad.saveLoadRes

func _pressed() -> void:
	res.delete()
	get_tree().paused = false
	get_tree().reload_current_scene()
	
