extends CharacterBody3D
class_name Player

# the monstrosity
@export_group("Numbers")

@export_subgroup("Speeds")
@export var sprintSpeed: float = 5
@export var baseSpeed: float = 3

@export_subgroup("Jumps")
@export var jumpVel: float = 2
@export var maxJumps: int = 2

@export_subgroup("Bhop")
@export var bHopResetTime := 0.5

@export_subgroup("Strengths")
@export var pushStrength := 2.0

@export_group("Bools")

@export_group("Nodes")

@export var speak: AudioStreamPlayer

@export_subgroup("Variable Nodes")
@export var money: MoneyComponent
@export var health: HealthComponent

@export_subgroup("Misc 3D")
@export var cam: Camera3D
@export var environment: TimedEnvironment
@export var light: SpotLight3D

#non-editor vars
var res = saveLoad.saveLoadRes
var speed: float = 3
var jumps := 0
var bHopTimer: float = 0
var currBHopMulti := 1.0

func _ready() -> void:
	Console.add_command("killAllEnemies", killEnemies)
	#region
	var pos = res.loadKey("pos")
	var hp = res.loadKey("hp")
	var maknee = res.loadKey("money")
	var yrot = res.loadKey("yrot")
	var hasTutored = res.loadKey("tutor")
	if pos is Vector3:
		global_position = pos
	if hp is int:
		health.health = hp
	if maknee is int:
		money.money = maknee
	if yrot is float:
		rotation.y = yrot
	if !(hasTutored is bool):
		await get_tree().create_timer(5).timeout
		TellInfo.sendPlayerInfo("so, uh just go outside and interact [E] with that box over there", 8)#              
		speak.play()
	
	#endregion
	

func _physics_process(delta: float) -> void:
	if environment:
		light.visible = not environment.day
	
	res.data["pos"] = global_position
	res.data["hp"] = health.health
	res.data["money"] = money.money
	res.data["yrot"] = rotation.y
	
	#Jump Region
	#region
	#Set Double jump to 0 on touching ground
	if is_on_floor():
		jumps = 0
		bHopTimer += delta
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		bHopTimer = 0
		currBHopMulti += 0.01
	
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and jumps < maxJumps:
		velocity.y = jumpVel
		jumps += 1
	
	if is_on_floor() and bHopTimer > bHopResetTime:
		currBHopMulti = 1
		bHopTimer = 0
	#endregion
	
	#Movement Region
	#region
	#Run Logic
	if Input.is_action_pressed("Run"):
		speed = sprintSpeed
	else:
		speed = baseSpeed
	
	#bunny hops
	speed *= clamp(currBHopMulti, 1, 50)
	
	#Actual Movement Shit
	var input_dir := Input.get_vector("A", "D", "W", "S")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	#endregion
	
	move_and_slide()
	pushRigidBodies()

func killEnemies():
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.queue_free()

func pushRigidBodies() -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider is RigidBody3D:
			var pushDir = -collision.get_normal()
			collider.apply_impulse(pushDir * pushStrength, collision.get_position() - collider.global_position)
