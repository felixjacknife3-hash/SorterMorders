extends Node

var sellMulti: float = 1

func addSellMulti(add: float) -> void:
	sellMulti += add

func resetAllUpgrades() -> void:
	sellMulti = 1
