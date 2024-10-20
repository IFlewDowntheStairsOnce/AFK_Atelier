extends Node2D

var ingredient_list = []
var potion_id : int
var brewing = false
@onready var bubbling_sound = $bubbling_AudioStreamPlayer2D
@onready var scrum_potion = preload("res://scenes/potions/scrum_potion.tscn")

signal brew_scrum
signal brew_pink

func _ready():
	add_to_group("cauldrons")

# When cauldron is clicked, brew potion
func _on_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		brewing = true

func _physics_process(delta: float) -> void:
	if brewing:
		bubbling_sound.play()
		potion_id = sum(ingredient_list)	# Potion id = sum of ingredient ids
		create_potion(potion_id)
		ingredient_list=[]	# Reset ingredient_list
		brewing = false

func sum(ingredient_list) -> int:
	var sum = 0
	for i in ingredient_list:	# Add ingredient ids together
		sum += i
	return sum

func create_potion(potion_id) -> void:
	match potion_id:
		3:
			emit_signal("brew_scrum")
		7:
			emit_signal("brew_pink")
		_:
			print("this potion don't exist!!!")

# Function for adding ingredients
func _on_add_ingredient(id) -> void:
	ingredient_list.append(id)
	print(ingredient_list)
