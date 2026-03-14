extends Button
class_name ComputerNormalButton


var colShapeObj: CollisionShape2D = null
var area: Area2D = null

@export var shape: Shape2D

func _ready() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func press():
	pass

func buildColRegion():
	var newColObj = CollisionShape2D.new()
	var newAreaObj = Area2D.new()
	
	area = newAreaObj
	add_child(area)
	
	colShapeObj = newColObj
	area.add_child(colShapeObj)
	
	colShapeObj.shape = shape
	colShapeObj.position.x += size.x / 2
	colShapeObj.position.y += size.y / 2
