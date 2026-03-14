extends Node3D
class_name Screen

@export var playerViewing: bool
@export var cam: Camera3D

func stopViewing():
	cam.current = false
	playerViewing = true

func startViewing():
	cam.current = true
	playerViewing = false

func changeViewing():
	if playerViewing:
		stopViewing()
	else:
		startViewing()
