extends Control

@onready var volume_slider = $OptionsPanel/MarginContainer/VBoxContainer/VolumeSettings/VolumeSlider
@onready var mute_checkbox = $OptionsPanel/MarginContainer/VBoxContainer/MuteSettings/CheckBox

func _readu():
	# load saves values
	volume_slider.value = GameManager.volume
	mute_checkbox.button_pressed = GameManager.is_muted

# === VOLUME CHANGED ===
func _on_volume_slider_value_changed(value):
	GameManager.volume = value
	update_audio()

# === MUTE TOGGLE ===
func _on_mute_check_box_toggled(button_pressed):
	GameManager.is_muted = button_pressed
	update_audio()

# === UPDATE AUDIO SETTINGS ===
func update_audio():
	var bus_index = AudioServer.get_bus_index("Master")
	
	if GameManager.is_muted:
		AudioServer.set_bus_volume_db(bus_index, -80) # effectively mute
	else:
		var db = linear_to_db(GameManager.volume)
		AudioServer.set_bus_volume_db(bus_index, db)

func _on_back_button_pressed():
	if GameManager.previous_scene != "":
		get_tree().change_scene_to_file(GameManager.previous_scene)
	else:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
