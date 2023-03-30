extends Node3D

@onready var main = $".."

#func _ready():
	#pass

func _process(_delta):
	if main.isTarget:
		var target = main.target
		#print("target: ", target)
		#if not target:
		look_at(target.global_position, Vector3.UP)
		rotation_degrees.x = main.rotation_degrees.x
	pass
