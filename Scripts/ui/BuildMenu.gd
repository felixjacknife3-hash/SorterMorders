extends Control

@export var builder: Builder

var building: bool
var inTween: Tween
var outTween: Tween

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var screenScale = get_viewport_rect().size
	position = Vector2((screenScale.x - self.size.x) - 5, 5)
	
	if Input.is_action_just_pressed("Build"):
		building = not building
		visible = self.building
		builder.building = self.building
