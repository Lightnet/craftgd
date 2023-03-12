extends Node3D

@onready var main = $".."

#func _ready():
	#pass

func _process(_delta):
	if main.target:
		var target = main.target
		
		look_at(target.global_position, Vector3.UP)
		
		rotation_degrees.x = main.rotation_degrees.x
	pass
