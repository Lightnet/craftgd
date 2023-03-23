extends Node3D
# https://godotengine.org/qa/138857/rotating-a-projectile-to-point-a-direction
# https://docs.godotengine.org/en/stable/classes/class_node3d.html#class-node3d

@export var bullet:PackedScene
@export var can_shoot:bool = true
@onready var firepoint = $Node3D/MeshInstance3D/firepoint

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("fire") and can_shoot:
		shoot()
		#print("shoot...")
	pass

func shoot():
	can_shoot = false
	$shoot_timer.start()
	var b = bullet.instantiate()
	get_node("/root/Main").add_child(b)#depend on the order else error
	#b.set_global_transform(firepoint.global_transform)
	b.set_global_rotation(firepoint.global_rotation)
	b.dir = firepoint.global_transform.basis.z    #fwd dir of weapon model
	b.set_global_position(firepoint.global_position)
	#get_node("/root/Main").add_child(b)# error here
	
	pass

func _on_shoot_timer_timeout():
	can_shoot = true
