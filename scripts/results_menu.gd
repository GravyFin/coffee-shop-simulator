extends Control

@onready var customers_label = $ResultsPanel/MarginContainer/VBoxContainer/CustomerNo
@onready var revenue_label = $ResultsPanel/MarginContainer/VBoxContainer/Revenue
@onready var coffee_quality_label = $ResultsPanel/MarginContainer/VBoxContainer/CoffeeQuality
@onready var popularity_label = $ResultsPanel/MarginContainer/VBoxContainer/Popularity
@onready var staff_happiness_label = $ResultsPanel/MarginContainer/VBoxContainer/StaffHappiness
@onready var feedback_label = $ResultsPanel/MarginContainer/VBoxContainer/Feedback

func update_shop_stats():
	# Advertising -> Popularity
	if GameManager.advertising_spend == 0:
		GameManager.popularity -= 20
	else:
		GameManager.popularity += int(GameManager.advertising_spend / 10.0)
	
	# Equipment -> Coffee Quality
	if GameManager.equipment_spend == 0:
		GameManager.coffee_quality -= 20
	else: 
		GameManager.coffee_quality += int(GameManager.equipment_spend / 10.0)
	
	# Staff -> Staff Happiness
	if GameManager.staff_spend == 0:
		GameManager.staff_happiness -= 20
	else:
		GameManager.staff_happiness += int(GameManager.staff_spend / 10.0)
	
	clamp_stats()

func clamp_stats():
	GameManager.popularity = clamp(GameManager.popularity, 0, 100)
	GameManager.coffee_quality = clamp(GameManager.coffee_quality, 0, 100)
	GameManager.staff_happiness = clamp(GameManager.staff_happiness, 0, 100)

func calculate_customers() -> int:
	var base_customers = 10
	
	var popularity_bonus = GameManager.popularity / 10.0
	var quality_bonus = GameManager.coffee_quality / 10.0
	var happiness_bonus = GameManager.staff_happiness / 10.0
	
	return base_customers + popularity_bonus + quality_bonus + happiness_bonus

func calculate_revenue(customers: int) -> int:
	var price_per_coffee = 3
	var quality_multiplier = 1.0 + (GameManager.coffee_quality / 100.0)
	
	return int(customers * price_per_coffee * quality_multiplier)

func _ready():
	update_shop_stats()
	
	var customers = calculate_customers()
	var revenue = calculate_revenue(customers)
	
	GameManager.money += revenue
	GameManager.day += 1
	
	update_ui(customers, revenue)
	update_feedback()

func update_ui(customers: int, revenue: int):
	customers_label.text = "Customers today: %d" % customers
	revenue_label.text = "Money earned: %d" % revenue
	coffee_quality_label.text = "Coffee quality: %d " % GameManager.coffee_quality
	popularity_label.text = "Popularity: %d" % GameManager.popularity
	staff_happiness_label.text = "Staff Happiness: %d" % GameManager.staff_happiness

func update_feedback():
	var messages := []
	if GameManager.advertising_spend > 0:
		messages.append("Well done! Your advertising brought in more customers!! :D")
	else:
		messages.append("Not a lot of people knew about your shop! :(")
	
	if GameManager.equipment_spend > 0:
		messages.append("Well done! Your coffee tasted really good today! :D")
	else:
		messages.append("Uh oh! Some customers didn't like your coffee! :(")
	
	if GameManager.staff_spend > 0:
		messages.append("Well done! Your staff were super happy and worked very hard! :D")
	else:
		messages.append("Whoops! Your staff felt tired and sad today! :(")
	
	feedback_label.text = "\n".join(messages)

func _on_next_day_pressed():
	get_tree().change_scene_to_file("res://scenes/allocation_menu.tscn")
