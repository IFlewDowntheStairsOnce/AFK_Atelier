extends Control

signal Dialogue_Finished

@export_file("*.json") var d_file

var Dialogue = []
var Current_Dialogue_ID = 0
var D_Active = false

func _ready():
	$NinePatchRect.visable = false
	
func start():
	if D_Active:
		return
	D_Active = true	
	Dialogue = Load_Dialogue()
	Current_Dialogue_ID = -1
	Next_Script()
		
func Load_Dialogue():
	var File = FileAccess.open("res://dialogue/Customer_dialouge1.json", FileAccess.READ)
	var Content = JSON.parse_string(File.get_as_text())
	return Content
	
func _input(event):
	if !D_Active:
		return
	if event.is_action_pressed("ui_accept"):
		Next_Script()
		
func Next_Script():
	Current_Dialogue_ID += 1
	if Current_Dialogue_ID >= len(Dialogue):
		D_Active = false
		$NinePatchRect.visable = false
		emit_signal("Dialogue_Finished") 
		return
		
	$NinePatchRect/Name.text = Dialogue[Current_Dialogue_ID]['name']
	$NinePatchRect/Text.text = Dialogue[Current_Dialogue_ID]['text']
