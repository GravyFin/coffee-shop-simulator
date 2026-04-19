extends Control

const STEP := 50

var ad_spend := 0
var eq_spend := 0
var sf_spend := 0

@onready var day_label = $"Day+MoneyPanel/DayPanel/MarginContainer/Label"
@onready var money_label = $"Day+MoneyPanel/MoneyPanel/MarginContainer/Label"

@onready var ad_amount = $OptionsPanel/AdvertisingPanel/MarginContainer/VBoxContainer/AdvertValuePanel/Denom
@onready var eq_amount = $OptionsPanel/EquipmentPanel/MarginContainer/VBoxContainer/EquipValuePanel/Denom
@onready var sf_amount = $OptionsPanel/StaffPayPanel/MarginContainer/VBoxContainer/StaffValuePanel/Denom

@onready var coffee_quality_label = $AssetPanel/MarginContainer/GridContainer/QualityLabel
@onready var popularity_label = $AssetPanel/MarginContainer/GridContainer/PopLabel
@onready var staff_happiness_label = $AssetPanel/MarginContainer/GridContainer/StaffLabel

func _ready():
	day_label.text = "Day: %d" % GameManager.day
	update_ui()
	update_stats_display()

# === HELPER FUNCTIONS ===
func remaining_money() -> int:
	return GameManager.money - ad_spend - eq_spend - sf_spend

func update_ui():
	money_label.text = "Money: £%d" % remaining_money()
	ad_amount.text = "£%d" % ad_spend
	eq_amount.text = "£%d" % eq_spend
	sf_amount.text = "£%d" % sf_spend

# === BUTTON CALLBACKS ===
# === ADVERTISEMENT BUTTONS ===
func _on_ad_plus_pressed():
	if remaining_money() >= STEP:
		ad_spend += STEP
		update_ui()
		MusicPlayer.play_high()

func _on_ad_minus_pressed():
	if ad_spend >= STEP:
		ad_spend -= STEP
		update_ui()
		MusicPlayer.play_low()

# === EQUIPMENT BUTTONS ===
func _on_eq_plus_pressed():
	if remaining_money() >= STEP:
		eq_spend += STEP
		update_ui()
		MusicPlayer.play_high()

func _on_eq_minus_pressed():
	if eq_spend >= STEP:
		eq_spend -= STEP
		update_ui()
		MusicPlayer.play_low()

# === STAFF BUTTONS ===
func _on_sf_plus_pressed():
	if remaining_money() >= STEP:
		sf_spend += STEP
		update_ui()
		MusicPlayer.play_high()

func _on_sf_minus_pressed():
	if sf_spend >= STEP:
		sf_spend -= STEP
		update_ui()
		MusicPlayer.play_low()

# === STAT PRINTS ===
# === COFFEE QUALITY ===
func coffee_quality_to_stars(value: int) -> String:
	if value < 20:
		return "★☆☆☆☆"
	elif value < 40:
		return "★★☆☆☆"
	elif value < 60:
		return "★★★☆☆"
	elif value < 80:
		return "★★★★☆"
	else:
		return "★★★★★"

# === POPULARITY AND HAPPINESS ===
func value_to_description(value: int) -> String:
	if value < 20:
		return "Very low"
	elif value < 40:
		return "Low"
	elif value < 60:
		return "Okay"
	elif value < 80:
		return "High"
	else:
		return "Very high"

func update_stats_display():
	coffee_quality_label.text = coffee_quality_to_stars(GameManager.coffee_quality)
	popularity_label.text = value_to_description(GameManager.popularity)
	staff_happiness_label.text = value_to_description(GameManager.staff_happiness)

# === NEXT DAY BUTTON ===
func _on_end_day_pressed():
	MusicPlayer.play_high()
	var total_spend = ad_spend + eq_spend + sf_spend
	GameManager.money -= total_spend
	
	GameManager.advertising_spend = ad_spend
	GameManager.equipment_spend = eq_spend
	GameManager.staff_spend = sf_spend
	
	get_tree().change_scene_to_file("res://scenes/results_menu.tscn")

func _on_options_button_pressed():
	MusicPlayer.play_high()
	GameManager.previous_scene = "res://scenes/allocation_menu.tscn"
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")
