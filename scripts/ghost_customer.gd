extends CharacterBody2D

'''
CUSTOMER
When  in customer order Timer node customer will leave and be unsatisfied if no time
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
const Speed = 200
#ar Current_State = NEUTRAL

var Dir = Vector2.LEFT
@onready var Desk_Position = $AnimatedSprite2D/Desk_Position.global_position
@onready var End_Position = $AnimatedSprite2D/End_Position.global_position
@onready var Start_Pos = $AnimatedSprite2D/Start_Position.global_position
var Is_Roaming = true #not added as need concept for layout to path find where to go
var Is_Talking = false
var Potion_Given = false
var Player_in_Dialouge = false
var Money
var Purchase_Request = false
var potion_type: int  # Set this to represent the potion type
signal potion_received(potion_type)
var Current_Potion = -1  # Tracks which potion the player provides
signal Order_Log_Closed
signal Order1_Made
signal Order1_Done
signal CustomerLeft(Mood)

var Order1_Active = false
var Order1_Completed = false
var Potion1 = 0
var Customer_Potion_Request = -1

# Different Customer Moods ie "VIBE CHECK" LOLOOO
enum CustomerMood {
	NEUTRAL,
	SATISFIED,
	UNSATSIFIED
}

func _ready():
	randomize()
	Start_Pos = position
#	connect("potion_received", self, "_on_potion_1_received")

func _process(delta):
#if $AnimatedSprite2D.global_position 
	if $AnimatedSprite2D.global_position !=Start_Pos:
		Is_Roaming = true
		Move_to_Desk(delta)
	if $AnimatedSprite2D.global_position ==Start_Pos:
		Is_Roaming = true
		Move_to_Desk(delta)

	elif Potion_Given:
		Move_Away_From_Desk(delta)
# Continuously check if the order is completed
	if Order1_Active:
		Check_Potion_Order()
	#if Order2_Active():

func Choose(array): #pick potion
	array.shuffle()
	return array.front()
	
func Move(delta):
	if !Is_Talking:
		position += Dir * Speed * delta

func Move_to_Desk(delta):
	if Is_Roaming and !Is_Talking:
		$AnimatedSprite2D.global_position = $AnimatedSprite2D.global_position.move_toward(Desk_Position, delta*Speed)
	if $AnimatedSprite2D.global_position == Desk_Position:
		Is_Roaming = false
		
func Move_Away_From_Desk(delta):
	if Is_Roaming and !Is_Talking:
		$AnimatedSprite2D.global_position = $AnimatedSprite2D.global_position.move_toward(End_Position, delta*Speed)
	if $AnimatedSprite2D.global_position == Desk_Position:
		Is_Roaming = false

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

# Check if the potion delivered matches the customer's request
func Check_Potion_Order():
	if Potion_Given:
		CompleteOrder(CustomerMood.SATISFIED)
	else:
		print("Waiting for correct potion...")

# Complete the order based on the customer's mood
func CompleteOrder(mood: int):
	if mood == CustomerMood.SATISFIED:
		Money += 10
		print("Order completed! Current money: ", Money)
	elif mood == CustomerMood.UNSATSIFIED:
		Money -= 5
		print("Order failed. Current money: ", Money)
	Order1_Active = false
	emit_signal("Order1_Completed")

func _on_potion_received(id) -> void:
	if Order1_Active:
		print("Potion received: ", potion_type)
		# Validate the potion based on customer request
		if potion_type == Customer_Potion_Request:
			print("Correct potion! Completing order...")
			Potion_Given = true
			CompleteOrder(CustomerMood.SATISFIED)
		else:
			print("Incorrect potion. The customer wanted potion type: ", Customer_Potion_Request)
			CompleteOrder(CustomerMood.UNSATSIFIED)


func _on_order_1_done(delta) -> void:
	Is_Roaming = true
	Move_Away_From_Desk(delta)
