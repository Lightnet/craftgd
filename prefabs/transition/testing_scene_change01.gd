extends Node


# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func _on_btn_change_scene_pressed():
	SceneTransition.change_scene("res://prefabs/transition/scene_change01.tscn")
	pass # Replace with function body.
