extends Node2D

@export var id : int = 0
@export var initial_position : Vector2
var selected = false
var inside_cauldron = false
var added = false	# tracks if ingredient was already added to cauldron (fixes multi-placement bug)
@onready var splash_sound = $splash_AudioStreamPlayer2D
@onready var grab_sound = $grab_AudioStreamPlayer2D

signal add_ingredient

# Ingredient is selected when the left mouse button is clicked inside its Area2d.
func _on_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		grab_sound.play()
		selected = true
		var added = false
		print(added)

# Ingredient is unselected when the left mouse button is released.
# If ingredient is released inside cauldron, emit a signal with the ingredient id.
# If ingredient is outside the cauldron, return the ingredient to its initial position.
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("click"):
		selected = false
		if inside_cauldron and not added:
			splash_sound.play()
			emit_signal("add_ingredient", id)
			added = true
			global_position = initial_position
		else:
			var tween = get_tree().create_tween()
			tween.tween_property(self, "global_position", initial_position, 0.2).set_ease(Tween.EASE_OUT)

# If the ingredient enters a cauldron's Area2D, then the ingredient is inside the cauldron
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("cauldrons"):
		inside_cauldron = true

# If the ingredient leaves a cauldron's Area2D, then the ingredient is no longer inside the cauldron
func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("cauldrons"):
		inside_cauldron = false

# Ingredient follows the mouse while it is selected
func _physics_process(delta: float) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)

# Ingredient increases in size when mouse hovers over it (for flavor).
func _on_area_2d_mouse_entered() -> void:
	if not selected:
		scale = Vector2(1.05, 1.05)

# Ingredient returns to normal size when mouse is not hovering over it.
func _on_area_2d_mouse_exited() -> void:
	if not selected:
		scale = Vector2(1, 1)
