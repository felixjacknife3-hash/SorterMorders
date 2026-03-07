extends ShapeCast3D
class_name dragRay

var justEndDrag = false

signal dragging(dragObject: DraggableObject)
signal endDragging

func _process(_delta: float) -> void:
	if Input.is_action_pressed("Drag"):
		startDrag()
	else:
		if justEndDrag: return
		endDrag()

func startDrag():
	justEndDrag = false
	for i in get_collision_count():
		var rayResult = get_collider(i)
		if rayResult is DraggableObject:
			dragging.emit(rayResult)
			break

func endDrag():
	justEndDrag = true
	endDragging.emit()
