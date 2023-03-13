extends Node
# https://docs.godotengine.org/en/stable/classes/class_node.html#enum-node-processmode
# https://www.youtube.com/watch?v=WHGHevwhXCQ
# https://docs.godotengine.org/en/stable/classes/class_fileaccess.html
# https://docs.godotengine.org/en/stable/classes/class_json.html
# https://docs.godotengine.org/en/stable/tutorials/inputs/input_examples.html
var file_name = "user://keybinding.json"

var  key_dict = {
	"forward":87,
	"back":83,
	"right":68,
	"left":65,
	"jump":32,
	"crouch":4194325,
	"cyclefire":86,
	"fire":1,
	"altfire":2,
	"interact":70,
}

var setting_key = false

func _ready():
	load_keys()
	#get_child(0).visible = false
	#process_mode = true
	#set_process_mode(Node.PROCESS_MODE_PAUSABLE)
	pass

func load_keys():
	if FileAccess.file_exists(file_name):
		#print("EXIST")
		delete_old_keys()
		var file = FileAccess.open(file_name, FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			key_dict = data
			setup_keys()
		else:
			printerr("Corrupted Data!")
	else:
		#print("NOT EXIST")
		save_keys()
	pass

func setup_keys():
	for i in key_dict:
		#button > node > manage groups > "button_keys"
		for j in get_tree().get_nodes_in_group("button_keys"):
			if j.action_name == i:
				j.text = OS.get_keycode_string(key_dict[i])
		var newkey = InputEventKey.new()
		newkey.set_physical_keycode(int(key_dict[i]))
		InputMap.action_add_event(i, newkey)
	pass

func delete_old_keys():
	#print("DELETE KEYS")
	#remove old keys
	for i in key_dict:
		var oldkey = InputEventKey.new()
		#oldkey.scancode
		oldkey.set_physical_keycode(key_dict[i])
		#print("=======")
		#print("KEY:", i , " CODE:", key_dict[i])
		#print("KEY>>: ",  OS.get_keycode_string(key_dict[i]))
		InputMap.action_erase_event(i, oldkey)
	pass

func save_keys():
	var file = FileAccess.open(file_name, FileAccess.WRITE)
	file.store_string(JSON.stringify(key_dict))
	file.close()
	print("SAVE")
	pass

#func _process(delta):
	#pass
