extends Collector

@export var collision: Array[CollisionShape3D]

func setCollision(can: bool) -> void:
	for collider in collision:
		collider.disabled = not can

func isNormalAllowed(normal: Vector3, XZMinMax) -> bool:
	var withinX = normal.x > -XZMinMax and normal.x < XZMinMax
	var withinZ = normal.z > -XZMinMax and normal.z < XZMinMax
	if normal.y >= 0 and withinX and withinZ:
		return true
	else:
		return false

func raycast(from: Vector3, to: Vector3, length: float):
	var ray = PhysicsRayQueryParameters3D.create(
		from + Vector3.UP,
		from + to * length,
	)
	var space = get_world_3d().direct_space_state
	var rayResults = space.intersect_ray(ray)
	if !rayResults.is_empty():
		var pos = rayResults.get("position")
		var normal = rayResults.get("normal")
		global_position = pos
		if !isNormalAllowed(normal, 0.38):
			return
		if normal == Vector3(0, 1, 0):
			rotation = Vector3(0, PI/2, 0)
		else:
			look_at_from_position(pos, pos + normal)
			global_rotation_degrees.x -= 90

func _process(_delta: float) -> void:
	scale = Vector3.ONE
	#raycast(self.global_position, Vector3.DOWN, 1000)#      
