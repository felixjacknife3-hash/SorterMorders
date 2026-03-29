extends CharacterBody3D
class_name Enemy

@export var navAgent: NavigationAgent3D
@export var hurtBox: HurtBox

@export_group("Numbers")
@export var speed: float = 3
@export var pushStrength: float = 0.8
@export var atkDb: float = 0.2
@export var atkRadius: float = 5

@export_group("Animation Names")
@export var animPlr: AnimationPlayer
@export var walkAnim: StringName
@export var idleAnim: StringName
@export var attackAnim: StringName

var plr: Player

#Movement and physics
#region
func setPlayer() -> void:
	if get_tree().get_first_node_in_group("player"):
		plr = get_tree().get_first_node_in_group("player")

func setTarget() -> void:
	if !navAgent: return
	navAgent.target_position = plr.global_position

func getMoveDir() -> Vector3:
	if !navAgent: return Vector3(0, 0, 0)
	var currPos = global_position
	var targetPos = navAgent.get_next_path_position()
	
	var travelPos = targetPos - currPos
	return travelPos.normalized()

func pushRigidBodies() -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider is RigidBody3D:
			var pushDir = -collision.get_normal()
			collider.apply_impulse(pushDir * pushStrength, collision.get_position() - collider.global_position)

func gravitate() -> void:
	if not is_on_floor():
		velocity += get_gravity()

func animateMovement(moveDir: Vector3) -> void:
	look_at(plr.global_position, Vector3(0, 1, 0), true)
	rotation_degrees.x = 0
	rotation_degrees.z = 0
	if moveDir and animPlr:
		if !animPlr: return
		if animPlr.is_playing(): return
		animPlr.current_animation = walkAnim
	else:
		if !animPlr: return
		if animPlr.is_playing(): return
		animPlr.current_animation = idleAnim

func move() -> void:
	setPlayer()
	setTarget()
	
	var moveDir = getMoveDir()
	animateMovement(moveDir)
	
	velocity = (moveDir) * speed
	gravitate()

#endregion

func attack() -> void:
	if self.global_position.distance_to(plr.global_position) <= atkRadius:
		hurtBox.attack(atkDb)

func _physics_process(_delta: float) -> void:
	move()
	attack()
	move_and_slide()
	pushRigidBodies()
