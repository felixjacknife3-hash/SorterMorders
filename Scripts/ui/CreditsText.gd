extends Label

func _ready() -> void:
	var file = FileAccess.open("res://Credits.txt", FileAccess.READ)
	if !file: return
	self.text = file.get_as_text()
	
