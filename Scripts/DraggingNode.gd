extends Node
class_name DraggingNode

@export_group("Nodes")
@export var ray: dragRay
@export var dragTo: Marker3D

@export_group("Numbers")
@export var strength := 200.0
@export var rotStrength := 6.0
@export var damping := 3.0

@export_group("Resources")
@export var shapeHeld: Shape3D
@export var shapeUnheld: Shape3D

func drag(object: DraggableObject) -> void:
	ray.shape = shapeHeld
	var targetPos := dragTo.global_position
	var targetRot :=  dragTo.global_rotation
	var posDiff := targetPos - object.global_position
	var rotDiff := targetRot - object.global_rotation
	
	object.apply_central_force(posDiff * strength)
	object.linear_velocity *= (1.0 - damping * get_physics_process_delta_time())
	object.angular_velocity = rotDiff * rotStrength


func _stopDrag() -> void:
	ray.shape = shapeUnheld

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
