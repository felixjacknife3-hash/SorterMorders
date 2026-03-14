extends RayCast3D
class_name Interacter

# Called when the node enters the scene tree for the first time.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		collide()

func collide():
	var colliding = is_colliding()
	if colliding:
		var collider = get_collider()
		if not collider is Interactable: return
		collider.interact()
