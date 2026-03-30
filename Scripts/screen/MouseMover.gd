extends Node
class_name MouseMover

@export var mouse: UIMouse
@export var sens: float = 1.5

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse.position.x += event.relative.x * sens
		mouse.position.y += event.relative.y * sens
		mouse.position.x = clamp(mouse.position.x, 0, mouse.get_parent_control().size.x - 16)#      
		mouse.position.y = clamp(mouse.position.y, 0, mouse.get_parent_control().size.y - 16)
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			var btn = mouse.getButton()
			if btn:
				btn.press()
