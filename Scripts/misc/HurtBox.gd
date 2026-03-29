extends Area3D
class_name HurtBox

@export var damage: float = 20
@export var colShape: CollisionShape3D

var t := 0.0

func attack(onTime: float = 0.2) -> void:
	t = 0
	colShape.disabled = false
	await get_tree().create_timer(onTime).timeout
	if !(t >= onTime):
		colShape.disabled = true

func _process(delta: float) -> void:
	t += delta
