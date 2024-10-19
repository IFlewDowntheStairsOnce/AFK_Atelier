extends Area2D

signal potion_received(potion_type)

var potion_type: int = 5 # Define the potion type
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("potion_received", potion_type)  # Emit the signal with potion type


func _ready():
	add_to_group("potions")
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")

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
