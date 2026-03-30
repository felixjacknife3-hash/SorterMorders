extends ProgressBar

@export var health: HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = health.maxHealth

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = health.health
