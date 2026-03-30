extends Node

var sellMulti: int = 1

func addSellMulti(add: int) -> void:
	sellMulti += add

func resetAllUpgrades() -> void:
	sellMulti = 1
