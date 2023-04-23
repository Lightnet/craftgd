extends Control

@onready var le_player_name = $CenterContainer/VBoxContainer/HBoxContainer/LE_PlayerName
@onready var cb_gender = $CenterContainer/VBoxContainer/HBoxContainer2/cb_gender
@onready var btn_create_player = $CenterContainer/VBoxContainer/btnCreatePlayer

var player_data:PlayerData

func _on_btn_create_player_pressed():
	
	var isFemale = cb_gender.button_pressed
	print("isFemale: ", isFemale)
	
	print("Player Name: ", le_player_name.text)
	
	player_data = PlayerData.new()
	
	print("player_data: ", player_data)
	print("player_data: ", player_data.name)
	
	player_data.name = le_player_name.text
	
	
	if isFemale:
		player_data.gender = "female"
	
	GameData.save_player_data(player_data)
	
	pass
