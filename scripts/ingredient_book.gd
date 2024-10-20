extends Node2D

var selected = false
var display = false
var list

func _ready():
	list = get_node("Sprite2D/Control")

# Ingredient is selected when the left mouse button is clicked inside its Area2d.
func _on_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		if not selected:
			selected = true
		else:
			selected = false

# Ingredient follows the mouse while it is selected
func _physics_process(delta: float) -> void:
	if selected:
		list.show()
	else:
		list.hide()

# Book increases in size when mouse hovers over it (for flavor).
func _on_area_2d_mouse_entered() -> void:
	if not selected:
		scale = Vector2(1.05, 1.05)

# Book returns to normal size when mouse is not hovering over it.
func _on_area_2d_mouse_exited() -> void:
	if not selected:
		scale = Vector2(1, 1)
