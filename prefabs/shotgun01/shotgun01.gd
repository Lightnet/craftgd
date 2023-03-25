extends Node3D

var damage = 20
var spread = 10

@onready var raycontrainer = $handle/MeshInstance3D/firepoint/raycontainer
@onready var bulletdecal = preload("res://prefabs/bulletdecal/bulletdecaltest.tscn")
@onready var camera = $"../../Camera3D"

func _ready():
	randomize()
	for r in raycontrainer.get_children():
		r.target_position.x = randf_range(spread,-spread)
		r.target_position.y = randf_range(spread,-spread)
	pass
	
func _process(_delta):
	fire_shotgun()
	pass

func fire_shotgun():
	if Input.is_action_pressed("fire"):
		#print("FIRE")
		for r in raycontrainer.get_children():
			r.target_position.x = randf_range(spread,-spread)
			r.target_position.y = randf_range(spread,-spread)
			if r.is_colliding():
				var b = bulletdecal.instantiate()
				#r.get_collider().add_child(b)
				get_node("/root").add_child(b)
				b.global_transform.origin = r.get_collision_point()
				print("r.get_collision_normal(): ", r.get_collision_normal())
				#b.look_at(r.get_collision_normal())
				#b.look_at(r.get_collision_point() + r.get_collision_normal(), Vector3.UP)
				#b.look_at(r.get_collision_point()+ r.get_collision_normal(), Vector3.UP)
				
				#b.look_at(r.get_collision_point()+ r.get_collision_normal(), camera.global_transform.basis.z) #works
				
				b.look_at(r.get_collision_point()+ r.get_collision_normal(), global_transform.basis.z) #works
				
				
				if r.get_collider().is_in_group("Enemy"):
					r.get_collider().health -= damage
	pass
