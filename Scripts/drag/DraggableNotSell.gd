extends DraggableBody
class_name NormalDraggableBody

var res = saveLoad.saveLoadRes

func _ready() -> void:
	var swordPos = res.loadKey("swordPos")
	if swordPos is Vector3:
		global_position = swordPos

func _process(delta: float) -> void:
	res.data["swordPos"] = global_position
