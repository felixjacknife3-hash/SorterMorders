extends ShapeCast3D
class_name dragRay

var justEndDrag = false
var body: DraggableBody

signal dragging(dragObject: DraggableBody)
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
		if rayResult is DraggableBody:
			if body and rayResult == body:
				rayResult.held = true
				body = rayResult
				dragging.emit(rayResult)
				break
			elif not body:
				rayResult.held = true
				body = rayResult
				dragging.emit(rayResult)
				break
			else:
				continue
			

func endDrag():
	if body:
		body.held = false
	body = null
	justEndDrag = true
	endDragging.emit()
