extends Node2D

var ingredient_list = []
var potion_id : int
var brewing = false

func _ready():
	add_to_group("cauldrons")

# When cauldron is clicked, brew potion
func _on_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		brewing = true

func _physics_process(delta: float) -> void:
	if brewing:
		var sum = 0
		for i in ingredient_list:	# Add ingredient ids together
			sum += i
		potion_id = sum	# Potion id = sum of ingredient ids
		print(potion_id)
		ingredient_list=[]	# Reset ingredient_list
		brewing = false

# Function for adding ingredient 1
func _on_ingredient_add_ingredient(id) -> void:
	ingredient_list.append(id)
	print(ingredient_list)

# Function for adding ingredient 2
func _on_ingredient_2_add_ingredient(id) -> void:
	ingredient_list.append(id)
	print(ingredient_list)
