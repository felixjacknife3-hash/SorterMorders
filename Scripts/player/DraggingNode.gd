extends Node
class_name DraggingNode

@export_group("Nodes")
@export var ray: dragRay
@export var dragTo: Marker3D

@export_group("Numbers")
@export var strength := 200.0
@export var rotStrength := 6.0
@export var damping := 3.0
@export var rotThreshhold := 0.01

@export_group("Resources")
@export var shapeHeld: Shape3D
@export var shapeUnheld: Shape3D

func drag(object: DraggableBody) -> void:
	ray.shape = shapeHeld
	var targetPos := dragTo.global_position
	var targetRot :=  dragTo.global_rotation_degrees
	var posDiff := targetPos - object.global_position
	var rotDiff := targetRot - object.global_rotation_degrees
	rotDiff.x = wrapf(rotDiff.x, -170, 170)
	rotDiff.y = wrapf(rotDiff.y, -170, 170)
	rotDiff.z = wrapf(rotDiff.z, -170, 170)
	var rotDiffRad: Vector3
	rotDiffRad.x = deg_to_rad(rotDiff.x)
	rotDiffRad.y = deg_to_rad(rotDiff.y)
	rotDiffRad.z = deg_to_rad(rotDiff.z)
	
	object.apply_central_force(posDiff * (strength))
	object.linear_velocity *= (1.0 - damping * get_physics_process_delta_time())
	if deg_to_rad(rotDiff.y) <= rotThreshhold and deg_to_rad(rotDiff.y) >= -rotThreshhold:
		rotDiff.y = 0
	if deg_to_rad(rotDiff.x) <= rotThreshhold and deg_to_rad(rotDiff.x) >= -rotThreshhold:
		rotDiff.x = 0
	if deg_to_rad(rotDiff.z) <= rotThreshhold and deg_to_rad(rotDiff.z) >= -rotThreshhold:
		rotDiff.z = 0
	
	object.angular_velocity = (rotDiffRad * (rotStrength))


func _stopDrag() -> void:
	ray.shape = shapeUnheld

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
