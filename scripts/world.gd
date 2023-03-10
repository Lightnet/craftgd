extends Node

func _unhandled_input(_event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

#func _ready():
#	pass

