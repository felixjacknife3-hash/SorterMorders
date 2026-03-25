extends CharacterBody3D
class_name Enemy

@export var speed: float = 3
@export var navAgent: NavigationAgent3D
@export var animPlr: AnimationPlayer

@export_group("Animation Names")
@export var walk: StringName
@export var idle: StringName
@export var hurt: StringName

var plr: Player

func setPlayer() -> void:
	if get_tree().get_first_node_in_group("player"):
		plr = get_tree().get_first_node_in_group("player")

func setTarget() -> void:
	if !navAgent: return
	navAgent.target_position = plr.position

func getMoveDir() -> Vector3:
	if !navAgent: return Vector3(0, 0, 0)
	var currPos = global_position
	var targetPos = navAgent.get_next_path_position()
	
	var travelPos = targetPos - currPos
	return travelPos.normalized()

func  _ready() -> void:
	setPlayer()

func _physics_process(_delta: float) -> void:
	setTarget()
	var moveDir = getMoveDir()
	if moveDir and animPlr:
		if !animPlr: return
		animPlr.current_animation = walk
	else:
		if !animPlr: return
		animPlr.current_animation = idle
	look_at(plr.position, Vector3(0, 1, 0), true)
	rotation_degrees.x = 0
	rotation_degrees.z = 0
	
	velocity = (moveDir) * speed
	
	
	
	if not is_on_floor():
		velocity += get_gravity()
	
	move_and_slide()
