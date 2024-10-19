extends Node2D

func _physics_process(delta: float) -> void:
	if Input.is_action_just_released("pause"):
		get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
