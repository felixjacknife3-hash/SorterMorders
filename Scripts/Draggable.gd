@tool
extends RigidBody3D
class_name DraggableObject

func _init() -> void:
	angular_damp = 1

func _ready() -> void:
	if angular_damp < 1:
		angular_damp = 1
