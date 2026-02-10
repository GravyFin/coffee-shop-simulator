extends Node

# === BASIC VALUES ===
var day: int = 1
var money: int = 1000

# === PLAYER ALLOCATIONS ===
var advertising_spend: int = 0
var equipment_spend: int = 0
var staff_spend: int = 0

# === RESULTS ===
var customers: int = 0
var revenue: int = 0

# === SHOP STATS (0 - 100) ===
var coffee_quality: int = 50
var popularity: int = 50
var staff_happiness: int = 50

func reset_game():
	day = 1
	money = 1000
	coffee_quality = 50
	popularity = 50
	staff_happiness = 50
