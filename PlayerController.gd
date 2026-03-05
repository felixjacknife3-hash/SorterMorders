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
@export_subgroup("Drag")
@export var strength := 200.0
@export var damping := 3.0
@export_group("Bools")
@export_group("Nodes")
@export_subgroup("Misc 3D")
@export var head: Node3D
@export var environment: TimedEnvironment
@export var light: SpotLight3D
@export_subgroup("Drag")
@export var ray: dragRay
@export var dragTo: Marker3D
@export_group("Resources")
@export var shapeHeld: Shape3D
@export var shapeUnHeld: Shape3D

var speed: float = 3
var jumps = 0

var captured: bool = true

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion and captured:
		head.rotate_x(deg_to_rad(-event.relative.y * sens))
		rotate_y(deg_to_rad(-event.relative.x * sens))
		head.rotation_degrees.x = clamp(head.rotation_degrees.x, minXRot, maxXRot)

func drag(collider: DraggableObject) -> void:
	ray.shape = shapeHeld
	var target := dragTo.global_position
	var diff := target - collider.global_position
	
	collider.apply_central_force(diff * strength)
	collider.linear_velocity *= (1.0 - damping * get_physics_process_delta_time())

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
