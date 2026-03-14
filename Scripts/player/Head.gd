extends Node3D
class_name HeadObject

@export var sens: float = 1.6
@export var minXRot: float = -70
@export var maxXRot: float = 80

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_x(deg_to_rad(-event.relative.y * sens))
		get_parent().rotate_y(deg_to_rad(-event.relative.x * sens))
		rotation_degrees.x = clamp(rotation_degrees.x, minXRot, maxXRot)
