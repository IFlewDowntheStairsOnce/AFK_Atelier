extends Control

signal Dialogue_Finished

@export_file("*.json") var d_file

var Dialogue = []
var Current_Dialogue_ID = 0
var D_Active = false

func _ready():
	$NinePatchRect.visible = false
	await get_tree().create_timer(5).timeout
	$NinePatchRect.visible = true
	Start()

func Start():
	if D_Active:
		return
	D_Active = true
	print("Starting dialogue...")
	$NinePatchRect.visible = true  # Fix typo
	Dialogue = Load_Dialogue()
	print("Dialogue loaded: ", Dialogue)
	Current_Dialogue_ID = -1
	Next_Script()

func Load_Dialogue():
	var File = FileAccess.open("res://dialogue/Customer_dialouge1.json", FileAccess.READ)
	var Content = File.get_as_text()
	var Parsed_Content = JSON.parse_string(Content)
	if Parsed_Content.error != OK:
		print("Error parsing dialogue file: ", Parsed_Content.error)
		return []
	return Parsed_Content.result

func _input(event):
	if !D_Active:
		return
	if event.is_action_pressed("ui_accept"):
		Next_Script()

func Next_Script():
	Current_Dialogue_ID += 1
	print("Current Dialogue ID: ", Current_Dialogue_ID)
	if Current_Dialogue_ID >= len(Dialogue):
		D_Active = false
		$NinePatchRect.visible = false
		emit_signal("Dialogue_Finished")
		print("Dialogue finished.")
		return

	$NinePatchRect/Name.text = Dialogue[Current_Dialogue_ID]['name']
	$NinePatchRect/Text.text = Dialogue[Current_Dialogue_ID]['text']
	print("Showing dialogue: ", Dialogue[Current_Dialogue_ID]['text'])
