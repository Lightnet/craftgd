extends RayCast3D

@onready var marker_3d = $Marker3D

var hitpoint:Vector3 = Vector3.ZERO
var isHit:bool = false
var entity = null

func _ready():
	pass

func _process(_delta):
	if is_colliding():
		#print("HIT: ", get_collision_point())
		hitpoint = get_collision_point()
		isHit=true
		entity = get_collider()
	else:
		#var pos = get_target_position() * transform.basis.z
		#print("TARGET HIT: ", pos)
		hitpoint = marker_3d.global_position
		#print("TARGET HIT: ", hitpoint)
		isHit=false
		entity = null
	pass
