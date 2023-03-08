extends MarginContainer
# https://docs.godotengine.org/en/stable/tutorials/rendering/multiple_resolutions.html
# https://docs.godotengine.org/en/stable/classes/class_engine.html#class-engine-property-target-fps

@onready var UISettings = $"."

# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
# get_tree().root.content_scale_mode


#Engine.max_fps

func _on_btn_back_pressed():
	UISettings.hide()
	pass # Replace with function body.


func _on_btn_screen_size_pressed():
	print(DisplayServer.screen_get_size())
	pass # Replace with function body.
