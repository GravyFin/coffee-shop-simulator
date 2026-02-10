extends Button

func _on_pressed():
	GameManager.reset_game()
	get_tree().change_scene_to_file("res://scenes/allocation_menu.tscn")
