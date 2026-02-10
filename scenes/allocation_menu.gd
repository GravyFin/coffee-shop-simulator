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

func _ready():
	day_label.text = "Day: %d" % GameManager.day
	update_ui()

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

func _on_ad_minus_pressed():
	if ad_spend >= STEP:
		ad_spend -= STEP
		update_ui()

# === EQUIPMENT BUTTONS ===
func _on_eq_plus_pressed():
	if remaining_money() >= STEP:
		eq_spend += STEP
		update_ui()

func _on_eq_minus_pressed():
	if eq_spend >= STEP:
		eq_spend -= STEP
		update_ui()

# === STAFF BUTTONS ===
func _on_sf_plus_pressed():
	if remaining_money() >= STEP:
		sf_spend += STEP
		update_ui()

func _on_sf_minus_pressed():
	if sf_spend >= STEP:
		sf_spend -= STEP
		update_ui()

# === NEXT DAY BUTTON ===
func _on_end_day_pressed():
	GameManager.advertising_spend = ad_spend
	GameManager.equipment_spend = eq_spend
	GameManager.staff_spend = sf_spend
	
	get_tree().change_scene_to_file("res://scenes/results_menu.tscn")
