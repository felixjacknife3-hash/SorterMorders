extends Node
class_name MouseMover

@export var mouse: UIMouse

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse.position.x += event.relative.x
		mouse.position.y += event.relative.y
		mouse.position.x = clamp(mouse.position.x, 0, mouse.get_parent_control().size.x - 16)#      
		mouse.position.y = clamp(mouse.position.y, 0, mouse.get_parent_control().size.y - 16)
	if event is InputEventMouseButton:
		if event.button_index == 1:
			var btn = mouse.getButton()
			if btn:
				btn.press()
