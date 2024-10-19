extends CharacterBody2D

# Will Maybe have pathfinding if we have time lol
# const speed = 30
var Current_State = IDLE

#var Dir = Vector2.RIGHT
var Start_Pos
#var Is_Roaming = true #not added as need concept for layout to path find where to go
var Is_Talking = false
var Potion_Given = false

var Player
var Player_in_Dialouge = false

var Money

# Different Customer Moods ie "VIBE CHECK" LOLOOO
enum {
	IDLE,
	Satisfied,
	Unsatisfied
}

func _ready():
	randomize()
	Start_Pos = position

func _process(delta):
	if Current_State == 0 or Current_State == 1:
		$AnimatedSprite2D.play('Idle')
#elif Current_State== 2 and !Is_Talking:
#	if Dir.x == -1: $AnimatedSprite2D.play("Go_W")
#	if Dir.x == 1: $AnimatedSprite2D.play("Go_E")
#	if Dir.y == -1: $AnimatedSprite2D.play("Go_N")
#	if Dir.y == 1: $AnimatedSprite2D.play("Go_S")

if Potion_Given:
	match Current_State:
	IDLE: pass
	Satisfied: Money = # add MONEY
	Unsatisfied: Money = # THEY WANT REFUND
		
