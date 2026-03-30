extends Control
class_name UIMouse

var onButton: bool = false
@export var button: CanvasItem

func getButton() -> ComputerNormalButton:
	if not button: return
	var btn = button.get_parent()
	if not btn: return null
	return btn

func areaEntered(_body):
	button = _body

func areaExited(_body):
	button = null
