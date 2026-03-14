extends Node
class_name HealthComponent

@export var maxHealth: int = 250
@export var health: int = int(1e12)

# Called when the node enters the scene tree for the first time.
func heal(amount: int) -> void:
	health += amount

func damage(amount: int) -> void:
	health -= amount
