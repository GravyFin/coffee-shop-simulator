extends Control

func _on_start_game_button_pressed():
	GameManager.reset_game()
	get_tree().change_scene_to_file("res://scenes/allocation_menu.tscn")

func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")

func _on_how_to_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/how_to_play.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
