extends Node
# https://docs.godotengine.org/en/stable/classes/class_diraccess.html

var save_data = "user://slot"

func _ready():
	pass

func _process(_delta):
	pass


func _on_btn_test_pressed():
	print("TEST")
	dir_contents(save_data)
	pass


func dir_contents(path):
	
	if DirAccess.dir_exists_absolute(path):
		print("FOUND: ", path)
	else:
		print("NOT FOUND: ", path)
		DirAccess.make_dir_absolute(path)
	var dir = DirAccess.open(path)
	print("dir: ", dir)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
