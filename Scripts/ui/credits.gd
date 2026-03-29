extends Button

@export var panel: Panel

func _pressed() -> void:
	panel.visible = !panel.visible
