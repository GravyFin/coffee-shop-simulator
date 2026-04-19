extends Control

func _on_back_button_pressed():
	MusicPlayer.play_low()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
