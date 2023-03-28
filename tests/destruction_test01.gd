extends Node3D


func _input(event):
	if event.is_action_pressed("EnterChat"):
		#$cube_01.destroy()
		$cube_01/Destruction.destroy()
