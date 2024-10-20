extends Node

@export var money : int = 0

func _ready() -> void:
	print("Current money: ", money)

func _on_customer_disatisfied() -> void:
	money -= 5
	print("Current money: ", money)

func _on_customer_satisfied() -> void:
	money += 5
	print("Current money: ", money)
