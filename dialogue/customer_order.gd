extends Control

signal Order_Log_Closed
signal Order1_Made

var Order1_Active = false
var Order1_Completed = false
var Potion1 = 0

func _process(delta):
	if Order1_Active:
		if Potion1 <= 1:
			print("Order1 Completed")
			Order1_Active = false
			Order1_Completed = true
	#if Order2_Active():

func Order1_Chat():
	$Order1_ui.visible = true

func Next_Order():
	if !Order1_Completed:
		Order1_Chat()
	else:
		$No_Order.visible = true
		await get_tree().create_timer(3).timeout
		$No_Order.visable = false

func _on_take_order_button_1_pressed() -> void:
	#$Order1_ui.visable = false #close order ui
	Order1_Active = true
	Potion1 = 0 #is potion in inventory
	emit_signal("Order1_Made")
	
	
	
