@tool
extends Node3D

@export var house: MissingNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

	transform = Transform3D(
		Vector3(0.9, 0, 0.42), 
		Vector3(0, 1, 0),
		Vector3(-0.4, 0, 0.9),
		Vector3(18.3, -0.5, 35.4)
		)
