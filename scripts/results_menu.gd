extends Control

@onready var customers_label = $ResultsPanel/MarginContainer/VBoxContainer/CustomerNo
@onready var revenue_label = $ResultsPanel/MarginContainer/VBoxContainer/Revenue
@onready var coffee_quality_label = $ResultsPanel/MarginContainer/VBoxContainer/CoffeeQuality
@onready var popularity_label = $ResultsPanel/MarginContainer/VBoxContainer/Popularity
@onready var staff_happiness_label = $ResultsPanel/MarginContainer/VBoxContainer/StaffHappiness
@onready var feedback_label = $ResultsPanel/MarginContainer/VBoxContainer/Feedback
@onready var tip_label = $ResultsPanel/MarginContainer/VBoxContainer/TipLabel

func update_shop_stats():
	# Advertising -> Popularity
	if GameManager.advertising_spend == 0:
		GameManager.popularity -= 15
	else:
		GameManager.popularity += int(GameManager.advertising_spend / 25.0)
	
	# Equipment -> Coffee Quality
	if GameManager.equipment_spend == 0:
		GameManager.coffee_quality -= 15
	else: 
		GameManager.coffee_quality += int(GameManager.equipment_spend / 25.0)
	
	# Staff -> Staff Happiness
	if GameManager.staff_spend == 0:
		GameManager.staff_happiness -= 15
	else:
		GameManager.staff_happiness += int(GameManager.staff_spend / 25.0)
	
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
	update_tip()

func update_ui(customers: int, revenue: int):
	customers_label.text = "Customers today: %d" % customers
	revenue_label.text = "Money earned: %d" % revenue
	coffee_quality_label.text = "Coffee quality: %d " % GameManager.coffee_quality
	popularity_label.text = "Popularity: %d" % GameManager.popularity
	staff_happiness_label.text = "Staff Happiness: %d" % GameManager.staff_happiness

func update_feedback():
	var messages := []
	
	var ad = GameManager.advertising_spend
	if ad == 0:
		messages.append("Whoops! Not a lot of people knew about your shop! :(")
	elif ad <= 100:
		messages.append("Okay.. your adverts helped a little bit, but there weren't that many!")
	elif ad <= 250:
		messages.append("You sold adverts well today, you got more customers than usual!")
	else:
		messages.append("Well done! Your adverts brought in a lot of customers! :D")
	
	var eq = GameManager.equipment_spend
	if eq == 0:
		messages.append("Uh oh! Your coffee didn't really taste that good today! :(")
	elif eq <= 100:
		messages.append("You made some upgrades and the coffee was a little bit better!")
	elif eq <= 250:
		messages.append("Your coffee was pretty good today thanks to the new machines!")
	else:
		messages.append("Well done! Your coffee tasted super yummy today! :D")
	
	var sf = GameManager.staff_spend
	if sf == 0:
		messages.append("Whoops! Your staff felt tired and sad today! :(")
	elif sf <= 100:
		messages.append("Your staff worked a little bit harder today!")
	elif sf <= 250:
		messages.append("Your staff worked were happy and hard-working today!")
	else:
		messages.append("You staff were super happy today, they worked super hard! :D")
	
	feedback_label.text = "\n".join(messages)

func generate_tip():
	var ad = GameManager.advertising_spend
	var eq = GameManager.equipment_spend
	var sf = GameManager.staff_spend
	
	# === ADVERTISING TIPS ===
	if ad == 0:
		tip_label.text = "Try spending some more money on advertising so people know about you coffee shop!"
		return
	elif ad <= 100:
		tip_label.text = "A little bit more advertising would bring in even more customers into to your coffee shop!"
		return
	
	# === EQUIPMENT TIPS ===
	if eq == 0:
		tip_label.text = "Try to spend more money on your coffee shop equipment so you coffee tastes even better!"
		return
	elif eq <= 100:
		tip_label.text = "A little more money into your coffee equipment would make your coffee really yummy!"
		return
	
	# === STAFF TIPS ===
	if sf == 0:
		tip_label.text = "Try spending more money on you staff, they will be happier and work way harder for you!"
		return
	elif sf <= 100:
		tip_label.text = "Your staff would work way harder if you paid them a little bit more money!"
		return
	
	# === POSITIVE FEEDBACK ===
	tip_label.text = "Great job! Your coffee shop is running really well! Keep up the good work!"

func _on_next_day_pressed():
	get_tree().change_scene_to_file("res://scenes/allocation_menu.tscn")
