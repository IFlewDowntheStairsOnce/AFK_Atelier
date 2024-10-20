extends Control

signal dialogue_finished

@onready var label = $Label
@onready var timer = $Timer
@export_file("*.json") var d_file

var d_active = false
var dialogue = []
var current_dialogue_id = 0

func _ready():
	timer.start()
	$NinePatchRect.visible = false
	label.visible = false
	
func displayclock(delta):
	label.text.visible = true
	label.text = "%02d:%02d" % time_left() 
	
func start():
	if d_active:
		return
	d_active = true
	await get_tree().create_timer(5).timeout
	$NinePatchRect.visible = true
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()
	
func time_left():
	var time_left = timer.time_left
	var minuite = floor(time_left/60)
	var seconds = int(time_left)%60
	return[minuite, seconds]
	
func load_dialogue():
	var file = FileAccess.open("res://scripts/Customer_dialouge1.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content
	
func _input(event):
	if !d_active:
		return
	
	if event.is_action_pressed("ui_accept"):
		next_script()
	
	
func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		$NinePatchRect.visible = false
		d_active = false
		emit_signal("dialogue_finished")
		return 
		
	$NinePatchRect/Name.text = dialogue[current_dialogue_id]['name']
	$NinePatchRect/Text.text = dialogue[current_dialogue_id]['text']
	
