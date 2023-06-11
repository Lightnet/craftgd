extends Control

@onready var settings = $"../Settings"
@onready var research = $"../Research"
@onready var shop = $"../Shop"
@onready var rewards = $"../Rewards"
@onready var result_reward = $"../ResultRewards"
@onready var mail = $"../Mail"
@onready var offline = $"."

@onready var l_player_name = $VBoxContainer/HBoxContainer/Container/PlayerDataInfo/HBoxContainer/LPlayer_Name

var training_area = "res://maps/training_area01.tscn"

func _ready():
	GameData.update_player_data.connect(_on_update_player_data)
	#pass
func _exit_tree():
	GameData.update_player_data.disconnect(_on_update_player_data)
	#pass
func _on_update_player_data(_player_data:PlayerData):
	l_player_name.text = _player_data.name
	#pass
func _on_btn_training_pressed():
	SceneTransition.change_scene(training_area)
	#pass
func _on_btn_research_pressed():
	offline.hide()
	research.show()
	pass
func _on_btn_settings_pressed():
	offline.hide()
	settings.show()
	pass
func _on_btn_shop_pressed():
	offline.hide()
	shop.show()
	pass
func _on_btn_mail_pressed():
	offline.hide()
	mail.show()
	pass
