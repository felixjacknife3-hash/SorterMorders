extends ComputerNormalButton

@export var panel: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buildColRegion()
	# functional code here


func press() -> void:
	panel.visible = !panel.visible
