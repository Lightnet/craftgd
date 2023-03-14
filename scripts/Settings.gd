extends MarginContainer
# https://docs.godotengine.org/en/stable/tutorials/rendering/multiple_resolutions.html
# https://docs.godotengine.org/en/stable/classes/class_engine.html#class-engine-property-target-fps

@onready var UISettings = $"."

@onready var NCurrentFPS = $VBoxContainer/Panel/TabContainer/Graphic/GridContainer/LCurrent_FPS
@onready var NVSync = $VBoxContainer/Panel/TabContainer/Graphic/GridContainer/CB_Vsync
@onready var NWindowMode = $VBoxContainer/Panel/TabContainer/Graphic/GridContainer/OB_WindowModes

# Called when the node enters the scene tree for the first time.
func _ready():
	print("DisplayServer vsync_mode: ", DisplayServer.window_get_vsync_mode())
	if DisplayServer.window_get_vsync_mode() == 1:
		NVSync.button_pressed = true
	else:
		NVSync.button_pressed = false
	pass 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if NCurrentFPS:
		NCurrentFPS.text = str(Engine.get_frames_per_second())
		pass
	pass
# get_tree().root.content_scale_mode

func _on_btn_back_pressed():
	UISettings.hide()
	pass

func _on_btn_screen_size_pressed():
	print(DisplayServer.screen_get_size())
	pass

func _on_spin_b_fps_value_changed(value):
	var fps = int(value)
	if fps:
		Engine.max_fps = fps
	pass

func _on_cb_vsync_toggled(button_pressed):
	#print("button_pressed: ", button_pressed)
	#var displayid = DisplayServer.window_get_current_screen()
	if button_pressed:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	pass 

func _on_mb_window_mode_pressed():
	
	pass # Replace with function body.


func _on_ob_window_modes_item_selected(index):
	print("index: ",index)
	#var displayid = DisplayServer.window_get_current_screen()# display monitor
	#print("displayid: ", displayid)
	var primaryid = DisplayServer.get_primary_screen()
	print("primaryid: ", primaryid)
	var windowmode = DisplayServer.window_get_mode(primaryid)
	print("windowmode: ", windowmode)
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED, primaryid)
	if index == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED , primaryid)
	if index == 2:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN , primaryid)
	
	pass # Replace with function body.
