extends Control
@onready var label = $Order1_ui/Label
@onready var timer = $Order1_ui/Timer

signal Order_Log_Closed
signal Order1_Made
var Time_left
var minuite
var second
var Order1_Active = false
var Order1_Completed = false
var Potion1 = 0
var Money = 0 
var Customer_Potion_Request = 0

#unc _ready():
#$CustomerArea.connect("potion_received", self, "_on_potion_received")

func _on_potion_received(potion_type):
	if Order1_Active:
		if potion_type == Potion1:  # Assuming Potion1 is set earlier
			Money += 10  # Increase money for correct potion
			print("Correct potion delivered! Current money: ", Money)
		else:
			Money -= 5  # Decrease for incorrect potion
			print("Incorrect potion delivered! Current money: ", Money)

func Countdown_timer():
	Time_left = timer.time_left
	minuite = floor(Time_left/60)
	second = int(Time_left) % 60
	return[minuite, second]

func _process(delta):
	label.text = "%02d:%02d" % Countdown_timer()
	if Order1_Active:
		Check_Potion_Order()
		if Potion1 <= 1:
			print("Order1 Completed")
			Order1_Active = false
			Order1_Completed = true
			# If the timer is up
		if timer.time_left <= 0:
			Order1_Active = false
			print("Order1 failed due to timeout.")
	#if Order2_Active():

func Order1_Chat():
	$Order1_ui.visible = true

func Next_Order() -> void:
	if !Order1_Completed:
		Order1_Chat()
	else:
		$No_Order.visible = true
		await get_tree().create_timer(3).timeout
		$No_Order.visible = false

func _on_take_order_button_1_pressed() -> void:
	#$Order1_ui.visible = false #close order ui
	timer.start()  # Start the timer here
	Order1_Active = true
	Potion1 = 0 #is potion in inventory
	emit_signal("Order1_Made")
	
func Check_Potion_Order():
	Customer_Potion_Request = Get_Customer_Potion_Request()
 
	if Customer_Potion_Request == Potion1:
		Money += 10  # Increase money if they match
		print("Potion delivered successfully! Current money: ", Money)
	else:
		Money -= 5  # Decrease money if they don't match
		print("Potion mismatch! Current money: ", Money)

func Get_Customer_Potion_Request():
	if Potion1:
	# This is a placeholder function. Replace it with your actual logic to get the requested potion type.
		return 0  # Replace with actual customer request
	

	
	
