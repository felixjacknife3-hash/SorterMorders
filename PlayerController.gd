extends CharacterBody3D
class_name Player

@export_group("Numbers")
@export_subgroup("Speeds")
@export var sprintSpeed: float = 5
@export var baseSpeed: float = 3
@export_subgroup("Jumps")
@export var jumpVel: float = 2
@export var maxJumps: int = 2
@export_subgroup("Camera")
@export var sens: float = 1.6
@export var minXRot: float = -70
@export var maxXRot: float = 80
@export_group("Nodes")
@export_subgroup("3D")
@export var head: Node3D
@export var environment: TimedEnvironment
@export_subgroup("Light")
@export var light: SpotLight3D

var speed: float = 3
var jumps = 0

var captured: bool = true

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	#Head Movement Code
	if event is InputEventMouseMotion and captured:
		head.rotate_x(deg_to_rad(-event.relative.y * sens))
		rotate_y(deg_to_rad(-event.relative.x * sens))
		head.rotation_degrees.x = clamp(head.rotation_degrees.x, minXRot, maxXRot)

func _physics_process(delta: float) -> void:
	light.visible = not environment.day
	#Pause Region
	#region
	#Leave Captured Mouse Mode
	if Input.is_action_just_pressed("Esc"):
		if captured:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			captured = not captured
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			captured = true
	#endregion
	
	#Jump Region
	#region
	#Set Double jump to 0 on touching ground
	if is_on_floor():
		jumps = 0
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and jumps < maxJumps:
		velocity.y = jumpVel
		jumps += 1
	#endregion
	
	#Movement Region
	#region
	#Run Logic
	if Input.is_action_pressed("Run"):
		speed = sprintSpeed
	else:
		speed = baseSpeed
	
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
