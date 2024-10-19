extends Node2D

signal potion_received(potion_type)
@export var id : int = 0
var selected = false

#func _ready():
#	connect("body_entered", self, "_on_body_entered")
#	connect("body_exited", self, "_on_body_exited")

func _on_body_entered(body):
	if body.is_in_group("potions"):  # Check if it's a potion
		body.connect("input_event", self, "_on_potion_input_event", [body])

func _on_body_exited(body):
	if body.is_in_group("potions"):
		body.disconnect("input_event", self, "_on_potion_input_event")

func _on_potion_input_event(viewport, event, shape_idx, potion):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("potion_received", potion.potion_type)
		potion.queue_free()  # Remove the potion from the scene

# Function for picking potion up w/click input
func _on_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		selected = true

# Potion is unselected when the left mouse button is released.
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("click"):
		selected = false

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
