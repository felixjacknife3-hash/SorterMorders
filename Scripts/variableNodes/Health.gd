extends Node
class_name HealthComponent

@export var maxHealth: int = 250
var health: int = int(9e12)

signal die

func startDie():
	get_parent().queue_free()

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
	die.connect(startDie)

func _process(_delta: float) -> void:
	if health <= 0:
		die.emit()
		print("die")
	if health > maxHealth:
		health = maxHealth
