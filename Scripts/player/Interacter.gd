extends RayCast3D
class_name Interacter

var interactions = 0
var res = saveLoad.saveLoadRes

@export var speak: AudioStreamPlayer

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
		if !(collider is box): return
		if interactions == 0:
			speak.play()
			TellInfo.sendPlayerInfo("soo, you've interacted with the box, uhh something prolly flew out from there", 8.6)#            
			await get_tree().create_timer(8.6).timeout
			TellInfo.sendPlayerInfo("eghhh you hsould like take it and put it in the hole you saw earlier", 9)
			interactions += 1
			res.data["tutor"] = true
		
