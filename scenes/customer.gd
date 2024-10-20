extends CharacterBody2D

@export var expected_id : int = 0
var potion


const Speed = 200
var Dir = Vector2.LEFT
var Is_Roaming = true #not added as need concept for layout to path find where to go
var Is_Talking = false

@onready var Desk_Position = $AnimatedSprite2D/Desk_Position.global_position
@onready var End_Position = $AnimatedSprite2D/End_Position.global_position
@onready var Start_Pos = $AnimatedSprite2D/Start_Position.global_position



# Different Customer Moods ie "VIBE CHECK" LOLOOO
enum CustomerMood {
	NEUTRAL,
	SATISFIED,
	UNSATSIFIED
}

enum Customer {
	GHOST,
	VAMPIRE,
	WITCH
}

func _ready():
	randomize()
	Start_Pos = position

func Choose(array): 
	array.shuffle()
	return array.front()

func _process(delta):
#if $AnimatedSprite2D.global_position 
	if $AnimatedSprite2D.global_position !=Start_Pos:
		Is_Roaming = true
		Move_to_Desk(delta)
	if $AnimatedSprite2D.global_position ==Start_Pos:
		Is_Roaming = true
		Move_to_Desk(delta)
	
	if Input.is_action_just_pressed("chat"):
		Is_Roaming = false
		Is_Talking = true
		print("chat with npc")
		$Dialogue.start()
	
func Move(delta):
	if !Is_Talking:
		position += Dir * Speed * delta

func Move_to_Start(delta):
	if Is_Roaming and !Is_Talking:
		$AnimatedSprite2D.global_position = $AnimatedSprite2D.global_position.move_toward(Start_Pos, delta*Speed)
	if $AnimatedSprite2D.global_position == Start_Pos:
		Is_Roaming = false

func Move_to_Desk(delta):
	if Is_Roaming and !Is_Talking:
		$AnimatedSprite2D.global_position = $AnimatedSprite2D.global_position.move_toward(Desk_Position, delta*Speed)
	if $AnimatedSprite2D.global_position == Desk_Position:
		Is_Roaming = false
		Is_Talking = true
		
		
func Move_Away_From_Desk(delta):
	if Is_Roaming and !Is_Talking:
		$AnimatedSprite2D.global_position = $AnimatedSprite2D.global_position.move_toward(End_Position, delta*Speed)
	if $AnimatedSprite2D.global_position == End_Position:
		Is_Roaming = false
		queue_free()

func _on_give_potion(id):
	if expected_id == id:
		print("SATISFIED")
		emit_signal("SATISFIED")
		Move_Away_From_Desk(id)
	else:
		print("DISATISFIED")
		emit_signal("DISASTISFIED")
		Move_Away_From_Desk(id)

func _on_timer_timeout() -> void:
	$Timer.wait_time = Choose([0.5,1,1.5])

		
func _on_customer_order_order_log_closed() -> void:
	Is_Talking = false

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

func _on_dialogue_dialogue_finished():
	Is_Roaming = true
	Is_Talking = false
