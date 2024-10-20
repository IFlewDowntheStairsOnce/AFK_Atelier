extends CharacterBody2D

'''
CUSTOMER
Timer node leave if no time
function recieve signal then check epxpected id with potion id
	then change state based on result
	then signal for status
	despawn when off screen

ORDER
	Dialouge when recieve status signal and update will hold ui and texts
	
Potion
	connect to cauldran
	spawn and add ids
	fine!

What we need tp bug the artist about
Pirotize
- background
- desk
- indriednt book - book icon
- maybe shelf
- MORE potions
- ingredients [as much as you can - as what u can]
- customers

lol fuuny ending
yay - finanically free totally the next ceo
mid - coporate chain slave of fast food potions 
ur loser - u made the buisness die

'''


# Will Maybe have pathfinding if we have time lol
const Speed = 30
var Current_State = NEUTRAL

var Dir = Vector2.RIGHT
var Start_Pos
var Is_Roaming = true #not added as need concept for layout to path find where to go
var Is_Talking = false
var Potion_Given = false

var Player
var Player_in_Dialouge = false

var Money

var Purchase_Request = false
var Potion_Wanted

var potion_type: int  # Set this to represent the potion type

var Potion2
var Potion3

signal potion_received(potion_type)
signal Potion2_Collected
signal Potion3_Collected

var Current_Potion = -1  # Tracks which potion the player provides

signal Order_Log_Closed
signal Order1_Made

var Order1_Active = false
var Order1_Completed = false
var Potion1 = 0
var Customer_Potion_Request = -1



# Different Customer Moods ie "VIBE CHECK" LOLOOO
enum {
	NEUTRAL,
	SATISFIED,
	UNSATSIFIED
}
func _ready():
	randomize()
	Start_Pos = position
#	connect("potion_received", self, "_on_potion_1_received")

func _process(delta):
	if Current_State == NEUTRAL:
		# If you want to add effects or animations, you can do so here
		pass

	# Check for player input to interact with the ghost customer
	if Input.is_action_just_pressed("chat"):
		if !Is_Talking:
			Is_Talking = true
			
# Continuously check if the order is completed
	if Order1_Active:
		Check_Potion_Order()
		if Potion1 == 1:  # Adjust the potion count logic
			print("Order1 Completed")
			Order1_Active = false
			Order1_Completed = true
	#if Order2_Active():
'''
	if Is_Roaming: 
		match Current_State:
			IDLE:
				pass
			NEW_DIR: 
				Dir = Choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
			MOVE:
				Move(delta)

	if Input.is_action_just_pressed("chat"):
		print ("Chatting---")
		$Dialogue.Start()
	#Is_Roaming = false
		Is_Talking = true
		$AmimatedSprite2D.play("Idle")
		
	if Input.is_action_just_pressed("order"):
		print("Order Recieved")
		$Customer_Order.Next_Order()
#	Is_Roaming = false
		Is_Talking = true
		$AnimatedSprite2D.play("Idle")
		

if Potion_Given:
		match Current_State:
			IDLE: pass
			Satisfied: Money += 10# add MONEY
			Unsatisfied: Money -= 20 # THEY WANT REFUND
'''
func Choose(array): #pick potion
	array.shuffle()
	return array.front()
	
func Move(delta):
	if !Is_Talking:
		position += Dir * Speed * delta
'''
func _on_chat_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Player = body
		Player_in_Dialouge = true

func _on_chat_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		Player_in_Dialouge = false
'''

func _on_timer_timeout() -> void:
	$Timer.wait_time = Choose([0.5,1,1.5])
#	Current_State = Choose([IDLE, NEW_DIR, MOVE])


func _on_dialogue_dialogue_finished() -> void:
		Is_Talking = false#
#	Is_Roaming = true


func _on_customer_order_order_log_closed() -> void:
	Is_Talking = false
#Is_Roaming = true

func _on_drop_area_body_entered(body):
	if body.is_in_group("ghost_customers"):  # Ensure this matches your ghost customer group
		emit_signal("potion_received", potion_type)  # Emit signal when dropped
		
func ResetTalking():
	Is_Talking = false

func _on_body_entered(body):
	if body.is_in_group("potions"):  # Check if it's a potion
		body.connect("input_event", self, "_on_potion_input_event", [body])

func _on_body_exited(body):
	if body.is_in_group("potions"):
		body.disconnect("input_event", self, "_on_potion_input_event")

#unc _ready():
#$CustomerArea.connect("potion_received", self, "_on_potion_received")
# This function is called when a potion is received
func _on_potion_1_received(id):
	if Order1_Active:
		# Store the potion type and check if it's the one the customer wanted
		if potion_type == Customer_Potion_Request:
			print("Correct potion delivered! Completing order...")
			Money += 10
			Order1_Completed = true
			Order1_Active = false
		else:
			print("Incorrect potion. Current money: ", Money)

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
	Order1_Active = true
	Potion1 = 0 #is potion in inventory
	emit_signal("Order1_Made")

func Check_Potion_Order():
	if Current_Potion == Customer_Potion_Request:
		print("Correct potion received. Completing order...")
		Potion_Given = true
		CompleteOrder()
	else:
		print("Incorrect potion. The customer wanted potion type: ", Customer_Potion_Request)

'''
	if Potion1 == 0:  # Ensure the order is active
		Customer_Potion_Request = Get_Customer_Potion_Request()
		if Customer_Potion_Request > 0:  # Valid potion request
			if Potion_Given:  # Check if a potion has been given
				if Customer_Potion_Request == Potion1:
					Money += 10  # Correct potion
					print("Correct potion delivered! Current money: ", Money)
					CompleteOrder()
				else:
					Money -= 5  # Incorrect potion
					print("Incorrect potion delivered! Current money: ", Money)
'''

func CompleteOrder():
	if Potion_Given:
		Money += 10
		Order1_Completed = true
		Order1_Active = false
		print("Order completed! Current money: ", Money)
	else:
		print("Order not complete. Still waiting for the correct potion.")


func _on_potion_received(id) -> void:
	if Order1_Active:
		print("Potion received: ", potion_type)
		# Validate the potion based on customer request
		if potion_type == Customer_Potion_Request:
			print("Correct potion! Completing order...")
			Potion_Given = true
			CompleteOrder()
		else:
			print("Incorrect potion. The customer wanted potion type: ", Customer_Potion_Request)


func _on_potion_1_give_potion(id: Variant) -> void:
	if Order1_Active:
		if potion_type == Potion1:  # Compare with the requested potion type
			Potion_Given = true
			print("Correct potion delivered!")
			Money += 10
		else:
			print("Incorrect potion delivered!")
			Money -= 5
