extends Node
class_name MoneyComponent

@export var money: int = 100
@export var minMoneyUse: int = 2

# Called when the node enters the scene tree for the first time.
func addMoney(amount: int) -> void:
	money += amount

func subtractMoney(amount: int) -> bool:
	var subtractedAmount = money - amount
	if subtractedAmount < 0: return false
	if subtractedAmount == 0: 
		money = subtractedAmount
		money += 5
		return true
	money = subtractedAmount
	return true
