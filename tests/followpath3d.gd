extends PathFollow3D

@export var move_speed = 1

func _ready():
	pass

func _process(delta):
	progress += move_speed * delta
	pass
