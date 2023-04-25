extends Control

@onready var l_player_name = $VBoxContainer/HBoxContainer/Container/PlayerDataInfo/HBoxContainer/LPlayer_Name

var training_area = "res://maps/training_area01.tscn"

func _ready():
	GameData.update_player_data.connect(_on_update_player_data)
	pass
func _exit_tree():
	GameData.update_player_data.disconnect(_on_update_player_data)
	pass

func _on_update_player_data(_player_data:PlayerData):
	l_player_name.text = _player_data.name
	pass

func _on_btn_training_pressed():
	
	SceneTransition.change_scene(training_area)
	
	pass
