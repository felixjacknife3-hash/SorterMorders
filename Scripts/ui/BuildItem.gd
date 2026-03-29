extends TextureRect
class_name BuildItem

@export var scene: PackedScene
@export var pressNum: StringName
@export var builder: Builder
@export var price: int = 30

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(pressNum):
		builder.setScene(scene)
		builder.setPrice(price)
