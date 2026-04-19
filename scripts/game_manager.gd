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

# === AUDIO SETTINGS ===
var volume: float = 0.2
var is_muted: bool = false
var previous_scene: String = ""

func apply_audio_settings():
	var bus_index = AudioServer.get_bus_index("Master")
	
	if is_muted:
		AudioServer.set_bus_volume_db(bus_index, -80)
	else:
		var db = linear_to_db(volume)
		AudioServer.set_bus_volume_db(bus_index, db)
