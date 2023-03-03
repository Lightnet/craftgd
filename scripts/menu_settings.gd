extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_btn_save_pressed():
	PlayerSettings.save_settings()
	pass # Replace with function body.


func _on_btn_load_pressed():
	PlayerSettings.load_settings()
	pass # Replace with function body.
