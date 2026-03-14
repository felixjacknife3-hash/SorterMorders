extends Label

@export var slider: HSlider
@export_group("Items")
@export var items: Array[String]

func _process(_delta: float) -> void:
	if slider:
		text = items[slider.value]
