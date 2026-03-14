extends Node
class_name HealthComponent

@export var maxHealth: int = 250
var health: int = int(9e12)

# Called when the node enters the scene tree for the first time.
func heal(amount: int) -> void:
	health += amount
	health = clamp(health, 0, maxHealth)

func damage(amount: int) -> void:
	health -= amount

func increaseMaxHealth(amount: int) -> void:
	maxHealth += amount

func _ready() -> void:
	health = maxHealth
