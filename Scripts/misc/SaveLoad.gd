extends Resource
class_name SaveLoad

@export var data := {}
const saveFilePosition = "user://savefile.res"

func delete() -> void:
	data = {}
	ResourceSaver.save(self, saveFilePosition)

func saveFile() -> void:
	ResourceSaver.save(self, saveFilePosition)

func loadFile() -> void:
	var loadedFile = ResourceLoader.load(saveFilePosition)
	if !loadedFile: 
		saveFile()
		return
	if loadedFile is SaveLoad:
		data = loadedFile.data

func loadKey(key: String) -> Variant:
	var loadedKey = data.get(key)
	return loadedKey
