extends Control

# When play button is pressed, switch to game scene
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/options_menu.tscn")

# When quit button is pressed, quit game
func _on_exit_pressed() -> void:
	get_tree().quit()
