extends Node

@export var positionArray: Array[Node3D] = []
@export var enemyArray: Array[PackedScene] = []
@export var environment: TimedEnvironment

func getRandPos() -> Vector3:
	var rand = RandomNumberGenerator.new()
	var idx = rand.randi_range(0, len(positionArray))
	
	return positionArray[idx].global_position

func getRandEnemy() -> PackedScene:
	var rand = RandomNumberGenerator.new()
	var idx = rand.randi_range(0, len(enemyArray))
	
	return enemyArray[idx]

func spawnEnemies(amount: int) -> void:
	for i in range(amount):
		var pos = getRandPos()
		var enemy = getRandEnemy()
		
		var enemyInstance: Node3D = enemy.instantiate()
		enemyInstance.position = pos
		add_child(enemyInstance)
		
