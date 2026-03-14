extends DraggableBody
class_name SellableDraggableBody

@export var price: float = 20

func _ready() -> void:
	price *= UpgradeManager.sellMulti


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
