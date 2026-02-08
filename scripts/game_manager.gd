extends Node

var day: int = 1
var money: int = 1000

# player allocations
var advertising_spend: int = 0
var equipment_spend: int = 0
var staff_spend: int = 0

# results
var customers: int = 0
var revenue: int = 0

func reset_game():
	day = 1
	money = 100
