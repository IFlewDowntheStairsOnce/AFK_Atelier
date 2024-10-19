extends CharacterBody2D

# Will Maybe have pathfinding if we have time lol
# const speed = 30
var Current_State = IDLE
# var Is_Roaming = true #not added as need concept for layout to path find where to go
var Is_Talking = false

var Player
var

# Different Customer Moods ie "VIBE CHECK" LOLOOO
enum {
	IDLE,
	Satisfied,
	Unsatisfied
}
