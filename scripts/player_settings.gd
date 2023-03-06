extends Node
# https://docs.godotengine.org/en/latest/classes/class_fileaccess.html
# https://docs.godotengine.org/en/latest/tutorials/io/data_paths.html#doc-data-paths

# Called when the node enters the scene tree for the first time.
func _ready():
	load_settings()
#	pass # Replace with function body.

const SAVED_SETTINGS_FILE = "user://player_settings.dat"

var settings_data: Dictionary 

func save_settings():
	#var data = {
		#"auto_walk": true,
		#"play_music": true,
	#}
	#data = var_to_str(data)
	
	var file = FileAccess.open(SAVED_SETTINGS_FILE, FileAccess.WRITE)
	file.store_var(settings_data)
	file = null
	#print("Save")
	
func load_settings():
	#print("checking load file exist")
	if not FileAccess.file_exists(SAVED_SETTINGS_FILE):
		settings_data = {
			"auto_walk": true,
			"play_music": true,
		}
		save_settings()
	#print("... load file")
	var file = FileAccess.open(SAVED_SETTINGS_FILE, FileAccess.READ)
	settings_data = file.get_var()
	#print("DATA", settings_data)
	#print("DATA", settings_data["auto_walk"])
	#print("DATA", settings_data.auto_walk)
	file = null

	# Unsure if this is necessary, but it was in the documentation.
	return settings_data
