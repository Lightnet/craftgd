extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	Game.mode.connect(_on_mode)
	pass

func _on_mode(name):
	print("MODE: ", name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_btn_get_mode_pressed():
	print(Game.get_mode())
	pass

func _on_btn_set_mode_2_pressed():
	Game.mode.emit("creative")
	pass # Replace with function body.

func _on_btn_set_mode_1_pressed():
	Game.mode.emit("test")
	pass
