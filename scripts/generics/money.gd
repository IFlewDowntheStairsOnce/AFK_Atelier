extends Node

@export var money : int = 0

func _ready():
	print("Current money: ", money)

func _on_ghost_customer_satisfied() -> void:
	money += 5
	print("Current money: ", money)

func _on_ghost_customer_disatisfied() -> void:
	money -= 5
	print("Current money: ", money)
