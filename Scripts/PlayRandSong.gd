extends Node

@export var audio: Array[AudioStreamPlayer]

func _ready() -> void:
	while true:
		var rand = RandomNumberGenerator.new()
		rand.randomize()
		var num = rand.randi_range(0, len(audio) - 1)
		var playingAudio: AudioStreamPlayer = audio[num]
		playingAudio.play()
		await playingAudio.finished
