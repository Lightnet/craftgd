extends Node
# https://kidscancode.org/godot_recipes/4.x/basics/file_io/
var player_data_path = "user://playerdata01.tres" # player data
var player_research_data_path = "user://player_research_data01.tres"
var player_research_datas_path = "user://researchs/"
var player_inventory_data_path = "user://player_inventory_data01.tres"
var player_inventory_datas_path = "user://inventory/"

var player_equip_datas_path = "user://equips/"

var player_data:PlayerData
var player_research_data:PlayerResearch
var player_inventory_data:PlayerInventory

signal update_player_data(_player_data:PlayerData)
signal update_player_inventory_data(_player_inventory_data:PlayerInventory)
signal update_player_research_data(_player_research_data:PlayerResearch)

func _ready():
	check_folders()
	pass

func check_player_data_exist():
	if ResourceLoader.exists(player_data_path):
		return true
	return false
	#pass
	
func save_player_base_data():
	pass

func load_player_base_data():
	pass

# PLAYER INVENTORY
func save_player_inventory_data(_player_inventory_data:PlayerInventory):
	#update_player_data.emit(_player_data)
	player_inventory_data = _player_inventory_data
	ResourceSaver.save(_player_inventory_data, player_inventory_data_path)
	var count = 0
	for item_prop in player_inventory_data.inventory_data.slot_datas:
		if item_prop != null:
			ResourceSaver.save(item_prop, player_inventory_datas_path+""+str(count)+ ".tres")
		count += 1
		#pass
	count = 0
	for item_prop in player_inventory_data.equip_inventory_data.slot_datas:
		if item_prop != null:
			ResourceSaver.save(item_prop, player_equip_datas_path+""+str(count)+ ".tres")
		count += 1
		#pass
	#pass
	
func load_player_inventory_data():
	if ResourceLoader.exists(player_inventory_data_path):
		player_inventory_data = ResourceLoader.load(player_inventory_data_path)
		var dir = DirAccess.open(player_inventory_datas_path)
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			var count = 0
			while file_name != "":
				if dir.current_is_dir():
					#print("Found directory: " + file_name)
					pass
				else:
					#if ResourceLoader.exists()
					#print("Found file: " + file_name)
					#print("PATH: ", player_research_datas_path+file_name)
					var res_data = ResourceLoader.load(player_inventory_datas_path+file_name)
					#print("res_data: ", res_data)
					#print("res_data Name: ", res_data.item_data.name)
					#print("res_data: quantity: ", res_data.quantity)
					player_inventory_data.inventory_data.pick_up_slot_data(res_data)
					#print("inventory_data S: ", player_inventory_data.inventory_data.slot_datas)
					file_name = dir.get_next() #next loop
				count += 1
		dir = DirAccess.open(player_equip_datas_path)
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			var count = 0
			while file_name != "":
				if dir.current_is_dir():
					#print("Found directory: " + file_name)
					pass
				else:
					#if ResourceLoader.exists()
					#print("Found file: " + file_name)
					#print("PATH: ", player_research_datas_path+file_name)
					var res_data = ResourceLoader.load(player_equip_datas_path+file_name)
					#print("res_data: ", res_data)
					#print("res_data Name: ", res_data.item_data.name)
					#print("res_data: quantity: ", res_data.quantity)
					player_inventory_data.equip_inventory_data.pick_up_slot_data(res_data)
					#print("inventory_data S: ", player_inventory_data.equip_inventory_data.slot_datas)
					file_name = dir.get_next() #next loop
				count += 1
		
		update_player_inventory_data.emit(player_inventory_data)
		return player_inventory_data
	return null
# FOLDER CHECKS
func check_folders():
	check_name_folder("inventory")
	check_name_folder("equips")
	check_name_folder("researchs")
	check_name_folder("homebase")
	check_name_folder("quests")
	
func check_name_folder(_name):
	var dir = DirAccess.open("user://")
	if dir.dir_exists(_name):
		#print("researchs exist")
		pass
	else:
		dir.make_dir(_name)
		#print("researchs create")
	pass
# RESEARCH DATA
func save_player_research_data(_player_research_data:PlayerResearch):
	#update_player_data.emit(_player_data)
	player_research_data = _player_research_data
	ResourceSaver.save(player_research_data, player_research_data_path)
	for data in player_research_data.researchs:
		#print("Name: ", data.name)
		#print("Name: ", data.isUnlocked)
		ResourceSaver.save(data, player_research_datas_path+""+data.name+".tres")
	#pass

func update_player_research_data_slot(_research_data:ResearchData):
	
	for data in player_research_data.researchs:
		if data == _research_data:
			var index = player_research_data.researchs.find(data)
			player_research_data.researchs[index] = _research_data
			#print("Name: ", data.name)
			#print("IsUnlocked: ", player_research_data.researchs[index].isUnlocked)
			#print("FOUND R DATA FOR SAVE...")
			break
		pass
	for data in player_research_data.researchs:
		#print("Name: ", data.name)
		#print("Name: ", data.isUnlocked)
		ResourceSaver.save(data, player_research_datas_path+""+data.name+".tres")
		
	ResourceSaver.save(player_research_data, player_research_data_path, \
			ResourceSaver.FLAG_NONE \
			#ResourceSaver.FLAG_REPLACE_SUBRESOURCE_PATHS \
			#ResourceSaver.FLAG_BUNDLE_RESOURCES \
			)
	pass

func load_player_research_data():
	if ResourceLoader.exists(player_research_data_path):
		player_research_data = ResourceLoader.load(player_research_data_path)
		player_research_data.researchs = []
		var dir = DirAccess.open(player_research_datas_path)
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			while file_name != "":
				if dir.current_is_dir():
					#print("Found directory: " + file_name)
					pass
				else:
					#print("Found file: " + file_name)
					#print("PATH: ", player_research_datas_path+file_name)
					var res_data = load(player_research_datas_path+file_name)
					#print("res_data: ", res_data)
					player_research_data.researchs.append(res_data)
					file_name = dir.get_next() #next loop
					
		update_player_research_data.emit(player_research_data)
		return player_research_data
	return null
# PLAYER DATA
func save_player_data(_player_data):
	#print("Data:", _player_data)
	#print("[DATA]Player Name:", _player_data.name)
	update_player_data.emit(_player_data)
	player_data = _player_data
	ResourceSaver.save(player_data, player_data_path)
	
	#var save_game = FileAccess.open(player_data_path, FileAccess.WRITE)
	# JSON provides a static method to serialized JSON string.
	#var json_string = JSON.stringify(node_data)
	# Store the save dictionary as a new line in the save file.
	#save_game.store_line(json_string)
	#save_game.store_var(json_string)
	pass

func load_player_data():
	#print("LOAD PLAYER DATA")
	#var save_game = FileAccess.open(player_data_path, FileAccess.READ)
	#var theDict = save_game.get_var()
	#print("theDict: ",theDict)
	if ResourceLoader.exists(player_data_path):
		player_data = load(player_data_path)
		update_player_data.emit(player_data)
		return player_data
	return null
	#pass
