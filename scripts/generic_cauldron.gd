extends Node2D

var ingredient_list = []
var potion_id : int
var brewing = false

func _ready():
	add_to_group("cauldrons")

func _on_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		brewing = true

func _physics_process(delta: float) -> void:
	if brewing:
		var sum = 0
		for i in ingredient_list:
			sum += i
		potion_id = sum
		print(potion_id)
		ingredient_list=[]
		brewing = false

func _on_ingredient_add_ingredient(id) -> void:
	ingredient_list.append(id)
	print(ingredient_list)

func _on_ingredient_2_add_ingredient(id) -> void:
	ingredient_list.append(id)
	print(ingredient_list)
