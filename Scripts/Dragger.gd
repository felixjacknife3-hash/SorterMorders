extends ShapeCast3D
class_name dragRay

@export var player: Player

signal dragging(dragObject: DraggableObject)

func _process(delta: float) -> void:
	
	if Input.is_action_pressed("Drag"):
		interact()
	else:
		shape = player.shapeUnHeld

func interact():
	for i in get_collision_count():
		var rayResult = get_collider(i)
		if rayResult is DraggableObject:
			dragging.emit(rayResult)
