extends Node3D

@onready var raycast = $"../../RayCast3D2"
@onready var preplaceholder = preload("res://prefabs/prototyping/placeholders/ph_light_cube.tscn")
@onready var prebuild_obj = preload("res://prefabs/prototyping/light_grid_cube.tscn")
var placeholder = null
var snap_grid = 1 #32 = 1
var offset = Vector3(0,0.5,0)
var place_location = Vector3.ZERO
var select_block = null

func _ready():
	placeholder = preplaceholder.instantiate()
	get_node("/root/Main").add_child(placeholder)
	pass 

func _unhandled_input(_event):
	
	if Input.is_action_just_pressed("BuildBlock"):
		var mybuild = prebuild_obj.instantiate()
		mybuild.global_transform.origin = place_location
		get_node("/root/Main").add_child(mybuild)
		#pass
	if Input.is_action_just_pressed("DestroyBlock"):
		if select_block:
			select_block.queue_free()
			select_block = null
		pass
	#pass
	
func _process(_delta):
	#print("hit_obj", raycast)
	if raycast !=null:
		#print("is_colliding", raycast.is_colliding())
		if raycast.is_colliding():
			var hit_obj = raycast.get_collider()
			if hit_obj:
				select_block = hit_obj
			
			
			#print("hit_obj", hit_obj)
			if placeholder:
				var point = raycast.get_collision_point()
				point.x = floor(point.x) + offset.x
				point.y = floor(point.y) + offset.y
				point.z = floor(point.z) + offset.z
				place_location = point
				placeholder.global_transform.origin = point
			#hit_player.receive_damage.rpc_id(hit_player.get_multiplayer_authority())
			pass
	pass
