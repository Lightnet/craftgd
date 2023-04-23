extends Control

@onready var main = $Main
@onready var offline = $Offline
@onready var online = $Online
@onready var settings = $Settings
@onready var research = $Research
@onready var new_game = $NewGame

@export var homebase:String = "res://maps/home_base_setup.tscn"
@export var playscene:String = "res://maps/tower_defense_02.tscn"
@export var scene:PackedScene


@onready var btn_new_game = $Main/CenterContainer/VBoxContainer/btnNewGame
@onready var btn_single = $Main/CenterContainer/VBoxContainer/btnSingle

func _ready():
	main.show()
	offline.hide()
	online.hide()
	settings.hide()
	research.hide()
	btn_new_game.hide()
	btn_single.hide()
	new_game.hide()
	
	checkPlayerExist()
	
func checkPlayerExist():
	print("Checking Player Data...")
	if GameData.check_player_data_exist():
		var data = GameData.load_player_data()
		print("Data: ", data)
		print("Name: ", data.name)
		btn_single.show()
	else:
		btn_new_game.show()
	pass
	
#SINGLE
func _on_btn_single_pressed():
	main.hide()
	offline.show()
	pass
#ONLINE
func _on_btn_online_pressed():
	main.hide()
	online.show()
	pass
# SETTINGS
func _on_btn_settings_pressed():
	main.hide()
	settings.show()
	pass
 # PLAY
func _on_btn_play_pressed():
	# play game mode
	get_tree().change_scene_to_file(playscene)
	pass
# RESEARCH
func _on_btn_research_pressed():
	offline.hide()
	research.show()
	pass
#HOME BASE
func _on_btn_home_base_pressed():
	#check and load
	
	get_tree().change_scene_to_file(homebase)
	pass
#QUIT
func _on_btn_quit_pressed():
	get_tree().quit()
	pass

func _on_btn_new_game_pressed():
	main.hide()
	new_game.show()
	pass
