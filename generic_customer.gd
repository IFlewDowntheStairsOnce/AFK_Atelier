extends Node2D

@export var expected_id : int = 0
var potion

signal satisfied
signal disatisfied

func _on_give_potion(id):
	if expected_id == id:
		print("satisfied")
		emit_signal("satisfied")
	else:
		print("disatisfied")
		emit_signal("disatisfied")
