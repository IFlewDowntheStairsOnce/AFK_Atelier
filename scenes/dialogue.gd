extends Control

signal dialogue_finished

@export_file("*.json") var d_file

var d_active = false
var dialogue = []
var current_dialogue_id = 0

func _ready():
	$NinePatchRect.visible = false
	
func start():
	if d_active:
		return
	d_active = true
	await get_tree().create_timer(1).timeout
	$NinePatchRect.visible = true 
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()
	
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
	
