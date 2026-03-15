extends Node

@export var positionArray: Array[Node3D] = []
@export var enemyArray: Array[PackedScene] = []
@export var environment: TimedEnvironment
@export var multi: int = 3

var turnedNight: bool = false
var time: float
var currDay: int = 1

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

func getCurrDayCount(currTime: float) -> int:
	return int(ceil(environment.cycleLength / currTime))

func getEnemySpawnAmount(input: int) -> int:
	return ceil(clamp(input ** 0.7, 0, 1e5)) * 3

func _process(delta: float) -> void:
	time += delta
	currDay = getCurrDayCount(time)
	if not environment.day and not turnedNight:
		turnedNight = true
		spawnEnemies(getEnemySpawnAmount(currDay))
	elif environment.day:
		turnedNight = false
