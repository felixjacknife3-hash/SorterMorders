extends RigidBody3D
class_name DraggableObject

func _getMeshData() -> MeshInstance3D:
	for child in get_children():
		if not child is MeshInstance3D: break
		return child
	return null
