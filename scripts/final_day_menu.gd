extends Control

@onready var final_stats_label = $FinalResultsPanel/MarginContainer/VBoxContainer/FinalStats
@onready var feedback_label = $FinalResultsPanel/MarginContainer/VBoxContainer/Feedback
@onready var tip_label = $FinalResultsPanel/MarginContainer/VBoxContainer/TipText

func _ready():
	update_final_stats()
	update_feedback()
	update_tip()

# === FINAL STATS ===
func update_final_stats():
	final_stats_label.text = "Final money: £%d\nDays Completed: %d" % [
		GameManager.money,
		GameManager.day - 1
	]

# === FEEDBACK ===
func update_feedback():
	var messages := []
	
	# === POPULARITY ===
	if GameManager.popularity < 40:
		messages.append("You shop didn't really get a lot of cutsomers this week! :(")
	elif GameManager.popularity < 70:
		messages.append("Your shop had a good number of customers this week! Good job!")
	else:
		messages.append("Your shop was super popular this week. You got so many customers! :D")
	
	# === QUALITY ===
	if GameManager.coffee_quality < 40:
		messages.append("Your coffee didn't really taste that good this week! :(")
	elif GameManager.coffee_quality < 70:
		messages.append("Your coffee was good this week but it could be a little better!")
	else:
		messages.append("Your coffee tasted super yummy this week, everyone loved it! :D")
	
	# === HAPPINESS ===
	if GameManager.staff_happiness < 40:
		messages.append("Your staff weren't really that happy this week! :(")
	elif GameManager.staff_happiness < 70:
		messages.append("Your staff were happy with their hours and work this week!")
	else:
		messages.append("Your staff were super happy and worked really hard this week! :D")
	
	feedback_label.text = "\n".join(messages)

# === FINAL TUP ===
func update_tip():
	if GameManager.money < 800:
		tip_label.text = "You should try to balance your spending next time and spread it out!"
	elif GameManager.money < 1500:
		tip_label.text = "You spent you money well this week, but maybe spread it out a little more!"
	else:
		tip_label.text = "Amazing job! You spend your money really smartly this week and made even more!"

# === BUTTON ===
func _on_exit_button_pressed():
	MusicPlayer.play_low()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
