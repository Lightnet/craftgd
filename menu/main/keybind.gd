extends Button

@export var action_name = ""

var do_set = false


func _pressed():
	text = ""
	do_set = true
	
func _input(event):
	if do_set:
		#print(event.keycode)
		if event is InputEventMouseButton:
			print(event.button_mask)
		if event is InputEventKey:
			#remove the old key
			var newkey = InputEventKey.new()
			InputMap.action_erase_event(action_name, newkey)
			#Add the new key for this action
			InputMap.action_add_event(action_name, event)
			#show it as readable to the user
			print("KEYCODE: ", event.keycode)
			print("physical KEYCODE: ", event.physical_keycode)
			#text = OS.get_scancode_string(event.scancode)
			text = OS.get_keycode_string(event.physical_keycode)
			#update the keydictory with the scanscode to save
			Guikeybinding.key_dict[action_name] = event.physical_keycode
			#save the dictionary to json
			Guikeybinding.save_keys()
			#stop settings the key
			do_set = false
