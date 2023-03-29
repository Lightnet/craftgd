extends Node3D

#@onready var raycast = $"../../RayCast3D2"
@onready var preplaceholder = preload("res://prefabs/prototyping/placeholders/ph_light_cube.tscn")
#@onready var preplaceholder = preload("res://prefabs/prototyping/placeholders/placeholder.tscn")

@onready var prebuild_obj = preload("res://prefabs/prototyping/light_grid_cube.tscn")
#@onready var prebuild_obj = preload("res://prefabs/prototyping/placeholders/placeholder.tscn")
@onready var raycast = $RayCast3D

#@onready var blocks = $"/root/Main/world/blocks"
@onready var blocks = $"/root/main"
@export var rootpath = "/main/entities"

var placeholder = null
var snap_grid = 1 #32 = 1
var offset = Vector3(0,1,0)
var place_location = Vector3.ZERO
var select_block = null
var count = 100

func _ready():
	# Only process for the local player.
	#set_process(get_multiplayer_authority() == multiplayer.get_unique_id())
	#rpc("local_ph_spawn")
	
	#if not is_multiplayer_authority(): return
	local_ph_spawn()
	pass 
	
func _exit_tree():
	if placeholder:
		placeholder.queue_free()
	pass

func _unhandled_input(_event):
	if not is_multiplayer_authority(): return
	#print("Hello Test ID AUTH: ", get_multiplayer_authority())
	#if Input.is_action_just_pressed("BuildBlock") and event.is_pressed():
		#print("is_server", multiplayer.is_server())
		#print("REMOTE PEER ID :", multiplayer.get_remote_sender_id())
		#print("PEER ID :", multiplayer.get_unique_id())
		#print("AUTH PEER ID :", get_multiplayer_authority())
		#pass
	if Input.is_action_just_pressed("ClearTest"):
		print("....")
		pass
	pass
	
func _physics_process(_delta):
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
			#pass
	if Input.is_action_just_pressed("BuildBlock"):
		count+=1
		var mybuild = prebuild_obj.instantiate()
		var block_id = mybuild.name + "_" + Helper.generate_random_name()
		mybuild.name = block_id
		get_tree().root.add_child(mybuild)
		
		
		mybuild.global_transform.origin = place_location
		#get_node("/root/Main/world/blocks").add_child(mybuild)
		
		#rpc("place_block",block_id, place_location )
		
		#get_node( ).add_child(mybuild)
		#place_block.rpc()
		#print("CLICK PLACE?")
		#pass
	if Input.is_action_just_pressed("DestroyBlock"):
		if select_block:
			select_block.queue_free()
			select_block = null
		#pass
	#pass

@rpc("call_remote")
func place_block(block_id, pos):
	#print("remote build?")
	var mybuild = prebuild_obj.instantiate()
	mybuild.name = block_id
	mybuild.global_transform.origin = pos
	get_node("/root/Main/world/blocks").add_child(mybuild)
	pass

@rpc("any_peer","call_local")
func remove_block():
	
	pass

#@rpc("call_local")
func local_ph_spawn():
	#if not is_multiplayer_authority(): return
	
	placeholder = preplaceholder.instantiate()
	#var block_id = placeholder.name + "_" + Helper.generate_random_name()
	#placeholder.name = block_id
	var block_id = placeholder.name + "_" + Helper.generate_random_numbers()
	placeholder.name = block_id
	get_tree().root.add_child.call_deferred(placeholder)
	
	#rpc("ph_spawn", block_id)
	pass

@rpc("call_remote")
func ph_spawn(block_id):
	placeholder = preplaceholder.instantiate()
	placeholder.name = block_id
	get_node("/root/main").add_child(placeholder)
	pass
