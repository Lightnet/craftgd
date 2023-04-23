extends Node
# https://kidscancode.org/godot_recipes/4.x/basics/file_io/
var player_data_path = "user://playerdata01.tres"

var player_data:PlayerData

signal update_player_data(_player_data:PlayerData)

func check_player_data_exist():
	if ResourceLoader.exists(player_data_path):
		return true
	return false
	#pass

func save_player_data(_player_data):
	print("Data:", _player_data)
	print("[DATA]Player Name:", _player_data.name)
	update_player_data.emit(_player_data)
	player_data = _player_data
	ResourceSaver.save(_player_data, player_data_path)
	
	#var save_game = FileAccess.open(player_data_path, FileAccess.WRITE)
	# JSON provides a static method to serialized JSON string.
	#var json_string = JSON.stringify(node_data)
	# Store the save dictionary as a new line in the save file.
	#save_game.store_line(json_string)
	#save_game.store_var(json_string)
	pass

func load_player_data():
	print("LOAD PLAYER DATA")
	#var save_game = FileAccess.open(player_data_path, FileAccess.READ)
	#var theDict = save_game.get_var()
	#print("theDict: ",theDict)
	if ResourceLoader.exists(player_data_path):
		player_data = load(player_data_path)
		update_player_data.emit(player_data)
		return player_data
	return null
	#pass
