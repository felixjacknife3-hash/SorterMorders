extends Node
class_name MoneyComponent

@export var money: int = 100

# Called when the node enters the scene tree for the first time.
func addMoney(amount: int) -> void:
	money += amount

func subtractMoney(amount: int) -> void:
	var subtractedAmount = money - amount
	if subtractedAmount < 0: return
	money = subtractedAmount
