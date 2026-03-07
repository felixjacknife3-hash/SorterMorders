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

@export_subgroup("Camera")
@export var sens: float = 1.6
@export var minXRot: float = -70
@export var maxXRot: float = 80

@export_subgroup("Bhop")
@export var bHopResetTime := 0.5

@export_group("Bools")

@export_group("Nodes")

@export_subgroup("Misc 3D")
@export var head: Node3D
@export var environment: TimedEnvironment
@export var light: SpotLight3D

#non-editor vars
var speed: float = 3
var jumps := 0
var bHopTimer: float = 0
var currBHopMulti := 1.0

var captured: bool = true

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	#cam movement logic
	#region
	if event is InputEventMouseMotion and captured:
		head.rotate_x(deg_to_rad(-event.relative.y * sens))
		rotate_y(deg_to_rad(-event.relative.x * sens))
		head.rotation_degrees.x = clamp(head.rotation_degrees.x, minXRot, maxXRot)
	#endregion

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
		bHopTimer += delta
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		bHopTimer = 0
		currBHopMulti += 0.05
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
	
	speed *= clamp(currBHopMulti, 1, 50)
	
	#Actual Movement Shit
	var input_dir := Input.get_vector("A", "D", "W", "S")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and captured:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	#endregion
	
	move_and_slide()
