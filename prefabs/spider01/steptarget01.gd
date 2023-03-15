extends Marker3D

@onready var raycast = $RayCast3D
@onready var mesh = $"../Mark"
var hitpoint = Vector3.ZERO

func _ready():
	pass

func _process(_delta):
	if raycast:
		if raycast.is_colliding():
			hitpoint = raycast.get_collision_point()
			#mesh.global_position = hitpoint
			#mesh.set_global_position(hitpoint)
			print("hitpoint", hitpoint)
		pass
	pass
