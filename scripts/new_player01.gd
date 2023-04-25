extends Control

@onready var le_player_name = $CenterContainer/VBoxContainer/LE_PlayerName
@onready var cb_gender = $CenterContainer/VBoxContainer/HBoxContainer2/cb_gender
@onready var btn_create_player = $CenterContainer/VBoxContainer/btnCreatePlayer
@onready var offline = $"../Offline"
@onready var new_game = $"."

var player_data:PlayerData
var player_research_data:PlayerResearch
var player_inventory_data:PlayerInventory

func _on_btn_create_player_pressed():
	
	var isFemale = cb_gender.button_pressed
	#print("isFemale: ", isFemale)
	#print("Player Name: ", le_player_name.text)
	
	player_data = PlayerData.new()
	player_research_data = PlayerResearch.new()
	player_inventory_data = PlayerInventory.new()
	#print("player_data: ", player_data)
	#print("player_data: ", player_data.name)
	
	if le_player_name.text.is_empty():
		print("EMPTY Name")
		return
	
	player_data.name = le_player_name.text
	
	if isFemale:
		player_data.gender = "female"
	
	GameData.save_player_data(player_data)
	
	var unit = load("res://research/researches/blank.tres")
	print("R Data: ", unit)
	#var tmp = unit.new()
	var tmp = unit
	print("R NAME: ", tmp)
	print("R NAME: ", tmp.name)
	player_research_data.researchs.append(tmp)
	unit = load("res://research/researches/comms.tres")
	player_research_data.researchs.append(unit)
	
	
	GameData.save_player_research_data(player_research_data)
	GameData.save_player_inventory_data(player_inventory_data)
	
	new_game.hide()
	offline.show()
	pass
