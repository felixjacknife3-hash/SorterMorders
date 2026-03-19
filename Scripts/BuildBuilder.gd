extends Node3D
class_name Builder

@export var cam: Camera3D
@export var rayLength: float = 20
@export var building: bool
@export var money: MoneyComponent
@export var shape: CylinderShape3D

var currScene: PackedScene = null
var sceneInstance: Node3D = null
var rays := 0
var price := 0

func _process(_delta: float) -> void:
	shootRay()
	if building:
		if not sceneInstance: return
		sceneInstance.show()
	else:
		if not sceneInstance: return
		sceneInstance.hide()
	if Input.is_action_just_pressed("Place"):
		place()

func setScene(scene: PackedScene) -> void:
	currScene = scene
	if sceneInstance:
		sceneInstance.queue_free()
		
	sceneInstance = currScene.instantiate()
	add_child(sceneInstance)
	sceneInstance.position = Vector3(0, 0, 0)
	if sceneInstance.has_method("setCollision"):
		print("collide")
		sceneInstance.setCollision(false)

func setPrice(priceAmount: int) -> void:
	price = priceAmount

func place() -> void:
	if !building: return
	
	#point check
	#region
	var point = PhysicsPointQueryParameters3D.new()
	point.position = self.global_position + (Vector3.UP / 10)
	var space = get_world_3d().direct_space_state
	var pointResults = space.intersect_point(point)
	if !pointResults.is_empty():
		TellInfo.sendPlayerInfo("[color=red]!You cannot place that there![/color]")
		return
	var shapeCheck = PhysicsShapeQueryParameters3D.new()
	shapeCheck.shape = shape
	shapeCheck.transform = Transform3D(Basis(), global_position + ((transform.basis.y * (shape.height / 2)) + (transform.basis.y * 0.2)))#              
	var shapeResults = space.intersect_shape(shapeCheck)
	if !shapeResults.is_empty():
		print("shape")
		TellInfo.sendPlayerInfo("[color=red]!You cannot place that there![/color]")
		return
	#endregion
	
	if !money.subtractMoney(price):
		TellInfo.sendPlayerInfo("[color=red]!You cant buy that![/color]")
		return
	
	if sceneInstance:
		if sceneInstance.has_method("setCollision"):
			sceneInstance.setCollision(true)
	
	sceneInstance.reparent(get_parent_node_3d().get_parent_node_3d())
	sceneInstance = null

#region
func isNormalAllowed(normal: Vector3, XZMinMax) -> bool:
	var withinX = normal.x > -XZMinMax and normal.x < XZMinMax
	var withinZ = normal.z > -XZMinMax and normal.z < XZMinMax
	if normal.y >= 0 and withinX and withinZ:
		return true
	else:
		return false

func shootRay():
	var mousePos = get_viewport().get_mouse_position()
	var from = cam.project_ray_origin(mousePos)
	var to = from + cam.project_ray_normal(mousePos) * rayLength
	var space = get_world_3d().direct_space_state
	var rayQuery = PhysicsRayQueryParameters3D.new()
	rayQuery.from = from
	rayQuery.to = to
	var rayResults = space.intersect_ray(rayQuery)
	if !rayResults.is_empty():
		var normal: Vector3 = rayResults.get("normal")
		rays += 1
		
		if isNormalAllowed(normal, 0.38):
			rays += 1
		else:
			return
		
		var currRay = rays
		var pos: Vector3 = rayResults.get("position")
		
		while rays == currRay:
			if normal == Vector3(0, 1, 0):
				rotation = Vector3(0, PI/2, 0)
			else:
				look_at_from_position(pos, pos + normal)
				global_rotation_degrees.x -= 90
			
			global_position = pos
			await get_tree().create_timer(0.1).timeout
#endregion
