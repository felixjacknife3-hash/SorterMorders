@abstract
extends RigidBody3D
class_name DraggableBody

@export var held: bool

func _init() -> void:
	angular_damp = 1

func _ready() -> void:
	if angular_damp < 1:
		angular_damp = 1
