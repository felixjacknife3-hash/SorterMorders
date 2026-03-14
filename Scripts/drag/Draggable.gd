@abstract
extends RigidBody3D
class_name DraggableBody

func _init() -> void:
	angular_damp = 1

func _ready() -> void:
	if angular_damp < 1:
		angular_damp = 1
