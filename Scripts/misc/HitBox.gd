extends Area3D
class_name HitBox

@export var healthComponent: HealthComponent

func entered(area: Area3D) -> void:
	if area is HurtBox:
		healthComponent.damage(area.damage)

func _ready() -> void:
	area_entered.connect(entered)
