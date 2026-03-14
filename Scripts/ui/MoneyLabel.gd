extends Label

@export var moneyComponent: MoneyComponent

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if moneyComponent:
		text = "$" + str(moneyComponent.money)
