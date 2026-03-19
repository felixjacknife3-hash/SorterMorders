extends RichTextLabel


func setText(textSet: String) -> void:
	text = textSet

func _ready() -> void:
	TellInfo.sendInfo.connect(setText)
