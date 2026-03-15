extends CharacterBody3D
class_name Enemy

@export var speed: float = 3
@export var navAgent: NavigationAgent3D

var plr: Player

func setPlayer() -> void:
	if get_tree().get_first_node_in_group("player"):
		plr = get_tree().get_first_node_in_group("player")

func setTarget() -> void:
	navAgent.target_position = plr.position

func getMoveDir() -> Vector3:
	var currPos = global_position
	var targetPos = navAgent.get_next_path_position()
	
	var travelPos = targetPos - currPos
	return travelPos.normalized()

func  _ready() -> void:
	setPlayer()

func _physics_process(_delta: float) -> void:
	setTarget()
	var moveDir = getMoveDir()
	
	velocity = (moveDir) * speed
	
	if not is_on_floor():
		velocity += get_gravity()
	
	move_and_slide()
