extends Control

@export var homebase:String = "res://maps/home_base_setup.tscn"
@export var playscene:String = "res://maps/tower_defense_02.tscn"
@export var scene:PackedScene

@onready var main = $Main
@onready var offline = $Offline
@onready var online = $Online
@onready var settings = $Settings
@onready var research = $Research
@onready var new_game = $NewGame
#@onready var play_mode = $PlayMode
@onready var game_mode = $PlayGameMode
@onready var btn_new_game = $Main/CenterContainer/VBoxContainer/btnNewGame
@onready var btn_single = $Main/CenterContainer/VBoxContainer/btnSingle
@onready var mail = $Mail
@onready var result_rewards = $ResultRewards
@onready var rewards = $Rewards
@onready var shop = $Shop

func _ready():
	hide_menus()
	main.show()
	checkPlayerExist()
	
func hide_menus():
	main.hide()
	offline.hide()
	online.hide()
	settings.hide()
	research.hide()
	btn_new_game.hide()
	btn_single.hide()
	new_game.hide()
	game_mode.hide()
	
	mail.hide()
	result_rewards.hide()
	rewards.hide()
	shop.hide()
	#play_mode.hide()
	
	
	
	pass
func checkPlayerExist():
	#print("Checking Player Data...")
	if GameData.check_player_data_exist():
		GameData.load_player_data()
		GameData.load_player_inventory_data()
		GameData.load_player_research_data()
		#print("Data: ", data)
		#print("Name: ", data.name)
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
	#get_tree().change_scene_to_file(playscene)
	#offline.hide()
	#play_mode.show()
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

func _on_btn_research_back_pressed():
	research.hide()
	offline.show()
	pass

func _on_btn_play_back_pressed():
	game_mode.hide()
	offline.show()
	pass

func _on_btn_game_modes_pressed():
	offline.hide()
	game_mode.show()
	pass
