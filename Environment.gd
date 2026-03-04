extends Node3D
class_name TimedEnvironment

@export var day := true
@export var dayLength: float = 2400
@export var nightLength: float = 600
@export_group("Light")
@export var sunLight: DirectionalLight3D
@export var animPlayer: AnimationPlayer

var cycleLength: float
var time := 0.0
var animPlayed := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cycleLength = dayLength + nightLength


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	time += delta
	var testTime = fmod(time, cycleLength)
	if testTime <= dayLength:
		day = true
	else:
		day = false
	
	if time > cycleLength:
		time = 0
	
	#Anim Logic
	#region
	if day and not animPlayed:
		animPlayer.current_animation = "Day"
		animPlayed = true
	if not day and animPlayed:
		animPlayer.current_animation = "Night"
		animPlayed = false
	#endregion
