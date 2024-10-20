extends Node2D

signal give_potion()
@export var id : int = 0
var selected = false
var in_customer = false
var in_trash = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("customers"):
		in_customer = true
	if area.is_in_group("trash"):
		in_trash = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("customers"):
		in_customer = false
	if area.is_in_group("trash"):
		in_trash = false

# Function for picking potion up w/click input
func _on_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		selected = true

# Potion is unselected when the left mouse button is released.
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("click"):
		selected = false
		if in_customer:
			print("in customer")
			emit_signal("give_potion", id)
			queue_free()
		if in_trash:
			queue_free()

# Potion follows the mouse while it is selected
func _physics_process(delta: float) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)

# Potion increases in size when mouse hovers over it (for flavor).
func _on_area_2d_mouse_entered() -> void:
	if not selected:
		scale = Vector2(1.05, 1.05)

# Potion returns to normal size when mouse is not hovering over it.
func _on_area_2d_mouse_exited() -> void:
	if not selected:
		scale = Vector2(1, 1) 
