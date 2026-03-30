extends Node3D
class_name TimedEnvironment

@export var day := true
@export var dayLength: float = 2400
@export var nightLength: float = 600
@export_group("Light")
@export var animPlayer: AnimationPlayer

var cycleLength: float
var time := 0.0
var animPlayed := false
var dayGoing := true
var res = saveLoad.saveLoadRes

func swapCanDayCycle() -> void:
	dayGoing = !dayGoing

func setTime(timeSet) -> void:
	var timeNum = float(timeSet)
	time = timeNum

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cycleLength = dayLength + nightLength
	Console.add_command("swapDayCycle", swapCanDayCycle)
	Console.add_command("setTime", setTime, ["time that is set"])
	var t = res.loadKey("time")
	if t is float:
		time = t


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	res.data["time"] = time
	if dayGoing:
		time += delta
	if time <= dayLength:
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
