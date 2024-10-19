extends Node2D

var ingredient_list = []

func _ready():
	add_to_group("cauldrons")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("ingredients"):
		if not area.is_connected("add_ingredient", Callable(self, "_on_ingredient_added")):
			area.connect("add_ingredient", Callable(self, "_on_ingredient_added"))
			print("Connected to add_ingredient signal.")

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("ingredients"):
		if area.is_connected("add_ingredient", Callable(self, "_on_ingredient_added")):
			area.disconnect("add_ingredient", Callable(self, "_on_ingredient_added"))
			print("Disconnected from add_ingredient signal.")

func _on_ingredient_added(id):
	ingredient_list.append(id)
	print(ingredient_list)
