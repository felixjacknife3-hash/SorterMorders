extends Area3D
class_name Interactable

signal interacted

# Called when the node enters the scene tree for the first time.
func interact():
	interacted.emit()
