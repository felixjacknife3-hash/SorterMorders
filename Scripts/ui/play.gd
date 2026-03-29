extends Button

@export var game: PackedScene

func _pressed() -> void:
	get_tree().change_scene_to_packed(game)
