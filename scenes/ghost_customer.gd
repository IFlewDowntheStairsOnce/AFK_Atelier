extends CharacterBody2D

# Will Maybe have pathfinding if we have time lol
const Speed = 30
var Current_State = IDLE

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

# Different Customer Moods ie "VIBE CHECK" LOLOOO
enum {
	IDLE,
	MOVE,
	NEW_DIR,
	WAITING_FOR_ORDER,
#Satisfied,
#Unsatisfied
}	
func _ready():
	randomize()
	Start_Pos = position
#$CustomerArea.connect("potion_received", self, "_on_potion_received")

func _process(delta):
	if Current_State == IDLE:
		# If you want to add effects or animations, you can do so here
		pass

	# Check for player input to interact with the ghost customer
	if Input.is_action_just_pressed("chat"):
		if !Is_Talking:
			Is_Talking = true
			AskForPotion()

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
#if Purchase_Request == true:
#	Potion_Wanted = Choose([Vector2.Potion1, Vector2.Potion2, Vector2.Potion3])
func AskForPotion():
	print("Ghost Customer: Please drag and drop a potion for me!")
	# Additional UI logic could go here (like showing a prompt on the screen)
 
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
	Current_State = Choose([IDLE, NEW_DIR, MOVE])


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
